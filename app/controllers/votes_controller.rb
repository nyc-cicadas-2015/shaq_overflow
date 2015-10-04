class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if logged_in?
			if vote_params[:question_id] != nil			
				question = Question.find_by(id: vote_params[:question_id])
				if question.votes.where({user_id: session[:user_id]}).count == 0
					question.votes.create(user_id: session[:user_id])
					flash[:message] = "Thanks for liking the question"
				else
					question.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the question"
				end
			elsif vote_params[:comment_id] != nil	
				comment = Comment.find_by(id: vote_params[:question_id])
				if comment.votes.where({user_id: session[:user_id]}).count == 0
					comment.votes.create(user_id: session[:user_id])
					flash[:message] = "Thanks for liking the question"
				else
					comment.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the comment"
				end			
			elsif vote_params[:response_id] != nil	
				response = Response.find_by(id: vote_params[:response_id])
				if response.votes.where({user_id: session[:user_id]}).count == 0
					response.votes.create(user_id: session[:user_id])
					flash[:message] = "Thanks for liking the response"
				else
					question.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the post"
				end
			end
		else
			redirect_to login_path
		end
		redirect_to root_path
	end

	private
	def vote_params
		params.require(:vote).permit(:question_id, :comment_id, :response_id)
	end
end
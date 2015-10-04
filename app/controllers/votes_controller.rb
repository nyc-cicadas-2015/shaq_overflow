class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if vote_params[:question_id] != nil			
			question = Question.find_by(id: vote_params[:question_id])
			if question.votes.where({user_id: session[:user_id]}) == []
				upvote = question.votes.build(user_id: session[:user_id])
				if upvote.save
					flash[:message] = "Thanks for liking the question"
				end
			else
				question = question.votes.find_by(user_id: session[:user_id])
				question.destroy
				flash[:message] = "You've unliked the post"
			end
		redirect_to root_path
		elsif vote_params[:comment_id] != nil	
			# logic goes here
		elsif vote_params[:response_id] != nil	
			# logic goes here
		end
	end

	private
	def vote_params
		params.require(:vote).permit(:question_id, :comment_id, :response_id)
	end
end
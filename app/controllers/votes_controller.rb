class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if logged_in?
			if vote_params[:question_id] != nil			
				question = Question.find_by(id: vote_params[:question_id])
				if question.votes.where({user_id: session[:user_id]}).count == 0
					question.votes.create(user_id: session[:user_id]) #I'd like to use merge here if possible
					flash[:message] = "Thanks for liking the question"
				else
					question.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the question"
				end
				redirect_to root_path

			elsif vote_params[:answer_id] != nil	
				answer = Answer.find_by(id: vote_params[:answer_id])
				if answer.votes.where({user_id: session[:user_id]}).count == 0
					answer.votes.create(user_id: session[:user_id])
					flash[:message] = "Thanks for liking the answer"
				else
					answer.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the answer"
				end
				redirect_to question_path(answer.question)

			elsif vote_params[:response_id] != nil	
				response = Response.find_by(id: vote_params[:response_id])
				if response.votes.where({user_id: session[:user_id]}).count == 0
					response.votes.create(user_id: session[:user_id])
					flash[:message] = "Thanks for liking the response"
				else
					response.votes.find_by(user_id: session[:user_id]).destroy
					flash[:message] = "You've unliked the response"
				end
			end
		else
			redirect_to login_path
		end
	end

	private
	def vote_params
		params.require(:vote).permit(:question_id, :answer_id, :response_id)
	end
end

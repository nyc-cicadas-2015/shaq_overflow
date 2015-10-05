class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if logged_in?
			if vote_params[:question_id] != nil		
				voting_subject = Question.find_by(id: vote_params[:question_id])
				proper_path = root_path
			elsif vote_params[:answer_id] != nil
				voting_subject = Answer.find_by(id: vote_params[:answer_id])
				proper_path = question_path(voting_subject.question)
			elsif vote_params[:response_id] != nil
				voting_subject = Response.find_by(id: vote_params[:response_id])
				proper_path = "undetermined for now"
			else
				redirect_to login_path
			end
			if voting_subject.votes.where({user_id: session[:user_id]}).count == 0
				voting_subject.votes.create(user_id: session[:user_id])
				flash[:message] = "Thanks for liking the #{voting_subject.class}"
			else
				voting_subject.votes.find_by(user_id: session[:user_id]).destroy
				flash[:message] = "You've unliked the #{voting_subject.class}"
			end
			redirect_to proper_path
		end
	end

	private
	def vote_params
		params.require(:vote).permit(:question_id, :answer_id, :response_id)
	end
end

class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if logged_in?
			voting_subject = find_associated_object(vote_params)
			proper_path = find_associated_redirect_path(vote_params, voting_subject)
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

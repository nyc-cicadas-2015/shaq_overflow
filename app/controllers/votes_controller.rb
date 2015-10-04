class VotesController < ApplicationController
	def new
		@vote = Vote.new
	end

	def create
		if vote_params[:question_id] != nil
			@question = Question.find_by(id: vote_params[:question_id])
			binding.pry
		end
	end

	private
	def vote_params
		params.require(:vote).permit(:question_id, :comment_id, :response_id)
	end
end
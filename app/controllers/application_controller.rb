class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    if session[:user_id]
      return User.find_by(id: session[:user_id])
    else
      return nil
    end
  end

	def logged_in?
	  session[:user_id]
	end

  def find_associated_object(vote_params)
    if vote_params[:question_id] != nil   
      voting_subject = Question.find_by(id: vote_params[:question_id])
    elsif vote_params[:answer_id] != nil
      voting_subject = Answer.find_by(id: vote_params[:answer_id])
    elsif vote_params[:response_id] != nil
      voting_subject = Response.find_by(id: vote_params[:response_id])
    end
    return voting_subject
  end

  def find_associated_redirect_path(vote_params, voting_subject)
    if vote_params[:question_id] != nil   
      proper_path = root_path
    elsif vote_params[:answer_id] != nil
      proper_path = question_path(voting_subject.question)
    elsif vote_params[:response_id] != nil
      proper_path = "undetermined for now"
    end
    return proper_path
  end

end

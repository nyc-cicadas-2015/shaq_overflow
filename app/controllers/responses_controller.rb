class ResponsesController < ApplicationController

  def new
    if logged_in?
      @question = Question.find_by(id: params[:question_id])
      @response = Response.new
    else
      redirect_to login_path
    end
  end


  def create
    question = Question.find_by(id: params[:response][:respondable_id])
    if params[:response][:body] == ""
      flash[:error] = "Response field cannot be empty"
      redirect_to new_question_response_path(question)
    else
      current_user.responses.create(params_response)
    end
  end


  private

  def params_response
    params.require(:response).permit(:body, :respondable_id,:respondable_type)
  end

end
class ResponsesController < ApplicationController

  def new
    @response = Response.new
  end


  def create
    if logged_in?
      user = current_user
      question = Question.find_by(id: params[:response][:question_id])
      if params[:response][:body] == ""
        flash[:error] = "Response field cannot be empty"
      else
        user.responses.create(params_response)
      end
      redirect_to question_path(question)
    else
      redirect_to login_path
    end
  end

  private

  def params_answer
    params.require(:response).permit(:body, :question_id)
  end

end
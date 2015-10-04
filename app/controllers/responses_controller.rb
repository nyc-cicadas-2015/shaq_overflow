class ResponsesController < ApplicationController

  def new
    @question = Question.find_by(id: params[:question_id])
    @response = Response.new
  end


  def create
    if logged_in?
      user = current_user
      question = Question.find_by(id: params[:response][:respondable_id])
      if params[:response][:body] == ""
        flash[:error] = "Response field cannot be empty"
      else
        user.responses.create(params_response)
      end
      redirect_to question_path(question.id)
    else
      redirect_to login_path
    end
  end

  private

  def params_response
    params.require(:response).permit(:body, :respondable_id,:respondable_type)
  end

end
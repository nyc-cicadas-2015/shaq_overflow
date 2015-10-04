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
    user = current_user
    question = Question.find_by(id: params[:response][:respondable_id])
    if params[:response][:body] == ""
      flash[:error] = "Response field cannot be empty"
      redirect_to new_question_response_path(question.id)
    else
      user.responses.create(params_response)
      redirect_to question_path(question)
    end
  end

  def edit
    @response = Response.find(params[:id])
  end



  private

  def params_response
    params.require(:response).permit(:body, :respondable_id,:respondable_type)
  end

end
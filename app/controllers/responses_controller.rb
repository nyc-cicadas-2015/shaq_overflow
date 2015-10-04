class ResponsesController < ApplicationController

  def new
    if logged_in?
      @question = Question.find_by(id: params[:question_id])
      @response = Response.new
    else
      redirect_to login_path
    end
  end

  def new_answer_response
    if logged_in?
      @answer = Answer.find_by(id: params[:answer_id])
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

  def create_answer_response
     user = current_user
    answer = Answer.find_by(id: params[:response][:respondable_id])
    if params[:response][:body] == ""
      flash[:error] = "Response field cannot be empty"
      redirect_to new_answer_response_path(answer)
    else
      user.responses.create(params_response)
      redirect_to question_path(answer.question)
    end
  end


  def edit
    @response = Response.find(params[:id])
  end

  def update
    response = Response.find(params[:id])
    response.update_attributes(params_response)
    if response.respondable_type == "Question"
      redirect_to question_path(response.respondable_id)
    else
      answer = Answer.find(response.respondable_id)
      redirect_to question_path(answer.question)
    end
  end

  def destroy
    response = Response.find_by(id: params[:id])
    if response.respondable_type == "Question"
      question_id = response.respondable_id
      redirect_to question_path(question_id)
    else
      answer = Answer.find(response.respondable_id)
      redirect_to question_path(answer.question)
    end
    flash[:delete] = "You have deleted your response"
    response.destroy
  end

  private

  def params_response
    params.require(:response).permit(:body, :respondable_id,:respondable_type)
  end

end
class ResponsesController < ApplicationController
  # I _think_ that all of these methods require a logged in user to function
  # properly.  I would likely use a before action instead of checking it in each
  # method.  This will clean up your controller methods quite a bit:
  #
  # before_action :require_login, except: [:index, :show]
  #
  # private
  #
  # def require_login
  #   unless logged_in?
  #     flash[:error] = 'You must be logged in to perform this action!'
  #     redirect_to login_path
  #   end
  # end

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
      @answer = Answer.find_by(id: params[:id])
      @response = @answer.responses.new
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
      redirect_to question_path(question.id)
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
    if params_response[:body] == ""
      flash[:error] = "Response field cannot be empty"
      redirect_to edit_response_path(response)
    else
      response.update_attributes(params_response)
      if response.respondable_type == "Question"
        redirect_to question_path(response.respondable_id)
      else
        answer = Answer.find(response.respondable_id)
        redirect_to question_path(answer.question)
      end
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

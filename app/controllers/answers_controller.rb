class AnswersController < ApplicationController

  def new
    user = current_user
    @answer = Answer.new
  end

  def create
    if logged_in?
      user = current_user
      question = Question.find_by(id: params[:answer][:question_id])
      if params[:answer][:body] == ""
        flash[:error] = "Answer field cannot be empty"
      else
        @answer = user.answers.create(params_answer)
      end
      if request.xhr?
        render partial: "answers/show", locals: {answer: @answer}, layout: false
      else
        redirect_to question_path(question)
      end
    else
      redirect_to login_path
    end
  end

  def edit
    @answer = Answer.find_by(id: params[:id])
  end

  def update
    answer = Answer.find_by(id: params[:id])
    question = answer.question
    if params[:answer][:body] == ""
      flash[:error] = "Answer field cannot be empty"
      redirect_to edit_answer_path(answer)
    else
      answer.update(params_answer)
      redirect_to question_path(question)
    end
  end

  def destroy
    answer = Answer.find_by(id: params[:id])
    answer.destroy
    redirect_to question_path(answer.question)
  end

  private

  def params_answer
    params.require(:answer).permit(:body, :question_id)
  end

end

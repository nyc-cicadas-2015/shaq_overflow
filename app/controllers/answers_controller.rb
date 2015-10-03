class AnswersController < ApplicationController

  def new
    user = current_user
    @answer = Answer.new
  end

  def create
    if logged_in?
      user = current_user
      question = Question.find_by(id: params[:answer][:question_id])
      user.answers.create(params_answer)
      redirect_to question_path(question)
    else
      redirect_to login_path
    end
  end

  private

  def params_answer
    params.require(:answer).permit(:body, :question_id)
  end

end

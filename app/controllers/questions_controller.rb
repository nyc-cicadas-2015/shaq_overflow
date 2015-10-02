class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    user = current_user
    user.questions.create(question_params)
    redirect root_path
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

end
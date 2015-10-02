class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    user = current_user
    if user
      user.questions.create(question_params)
      redirect_to root_path
    else
      puts "nah"
    end
  end

  private

  def question_params
    params.require(:question).permit(:body,:title)
  end

end
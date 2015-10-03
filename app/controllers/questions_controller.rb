class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
    @question = Question.find_by(id: params[:id])
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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
  end

  private

  def question_params
    params.require(:question).permit(:body,:title)
  end

end
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @answer = Answer.new
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answer = @question.answers.new
  end

  def create
    user = current_user
    if user
      user.questions.create(question_params)
      redirect_to root_path
    else
      flash[:login] = "You must login in order to create a post"
      redirect_to login_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update(question_params)
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:body,:title)
  end

end
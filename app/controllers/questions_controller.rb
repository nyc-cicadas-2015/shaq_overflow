class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @tag = Tag.new
    @answer = Answer.new
    @response = Response.new
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answer = @question.answers.new
  end

  def create
    if current_user
      question = current_user.questions.build(question_params)
      if question.check_for_empty_fields?
        flash[:input] = "Please input information"
        redirect_to new_question_path
      else
        question.save
        redirect_to root_path
      end
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
    if question.check_for_empty_fields?
     flash[:input] = "Please input information"
     redirect_to edit_question_path(question)
   else
    redirect_to root_path
  end
end

def destroy
  question = Question.find(params[:id])
  question.destroy
  redirect_to root_path
end

private

def question_params
  params.require(:question).permit(:body,:title)
end

 def tag_params
   params.require(:question).require(:tag).permit(:name)
 end

end
class AnswersController < ApplicationController

  def new
    # user = current_user
    @answer = Answer.new
  end

  def create
    if logged_in?
      # user = current_user # Why set a temp variable?  Just use current_user instead of user

      question = Question.find_by(id: params[:answer][:question_id])
      if params[:answer][:body] == ""
        flash[:error] = "Answer field cannot be empty"
      else
        @answer = current_user.answers.create(params_answer)
      end

      # In rails you really need to use the respond_to method to do this properly
      # respond_to do |fmt|
      #   fmt.html {}
      #   fmt.json { render partial: 'ans'}
      # end
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

    # If you have a proper validation on your model, you should be able to do
    #
    # if answer.update(params_answer)
    #   # This code will only run if the new answer to be updated to is valid?
    # else
    # end
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

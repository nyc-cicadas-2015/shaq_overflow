require "rails_helper"

describe AnswersController do
  let(:login_page) { LoginPageHelper.new }

  describe "POST #create" do
    describe "When successful" do
      before(:each) {
        @user = create(:user)
        session[:user_id] = @user.id
        @question = create(:question)
      }
      let(:question_attr) { attributes_for(:question) }
      let(:answer_attr) { attributes_for(:answer) }

      it "posts answer onto question page" do
        expect {
          post :create, answer: { body: answer_attr[:body], question_id: @question.id, user_id: @user.id }
        }.to change(Answer,:count).by(1)
        end

      end
    end
  end


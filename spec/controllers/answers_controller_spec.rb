require "rails_helper"

describe AnswersController do
  let(:login_page) { LoginPageHelper.new }

  describe "GET #create" do
    describe "When successful" do
      before(:each) {
        @user = create(:user)
        login_page.visit_page.login(@user)
        @question = create(:question)
      }
      let(:question_attr) { attributes_for(:question) }
      let(:answer_attr) { attributes_for(:answer) }

      it "posts answer onto question page" do
        expect(assigns(@question.answers.last.body)).to eq answer_attr[:body]
      end

    end
  end
end


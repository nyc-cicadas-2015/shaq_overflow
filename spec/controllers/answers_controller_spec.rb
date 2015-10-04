require "rails_helper"

describe AnswersController do

  describe "POST #create" do

    describe "When successful" do
      before(:each) {
        @user = create(:user)
        session[:user_id] = @user.id
        @question = create(:question)
      }

      let(:question_attr) { attributes_for(:question) }
      let(:answer_attr) { attributes_for(:answer) }

      it "increase answer count by 1" do
        expect {
          post :create, answer: { body: answer_attr[:body], question_id: @question.id, user_id: @user.id }
        }.to change(Answer,:count).by(1)
      end
    end

    describe "When unsuccessful" do

      it "should redirect if not logged in" do
        post :create
        expect(response).to redirect_to(login_path)
      end

      it "sets flash error if field empty" do
        user = create(:user)
        question = create(:question)
        session[:user_id] = user.id
        post :create, answer: { body: "", question_id: question.id }
        expect(flash[:error]).to have_content("Answer field cannot be empty")
      end

    end
  end

  describe "PATCH #update" do
    before(:each) {
        @user = create(:user)
        session[:user_id] = @user.id
        @question = create(:question)
        @answer = create(:answer)
    }

    describe "when successful" do

      it "changes answer body" do
        patch :update, id: @answer,  answer: { body: "change to this", question_id: @question.id, user_id: @user.id }
        @answer.reload
        @answer.body.should eq("change to this")
      end

    end

  end

end


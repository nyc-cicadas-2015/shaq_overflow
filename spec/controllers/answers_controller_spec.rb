require "rails_helper"

describe AnswersController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
    @question = create(:question)
  }

  describe "POST #create" do
    context "with valid attributes" do
      let(:answer_attr) { attributes_for(:answer) }

      it "increase answer count by 1" do
        log_me_in
        expect {
          post :create, answer: { body: answer_attr[:body], question_id: @question.id, user_id: @user.id }
        }.to change(Answer,:count).by(1)
      end
    end

    context "with invalid attributes" do
      it "should redirect if not logged in" do
        post :create
        expect(response).to redirect_to(login_path)
      end

      it "sets flash error if field empty" do
        log_me_in
        post :create, answer: { body: "", question_id: @question.id }
        expect(flash[:error]).to have_content("Answer field cannot be empty")
      end
    end
  end

  describe "PATCH #update" do
    before(:each) {
        log_me_in
        @answer = create(:answer)
    }

    context "valid attributes" do
      it "changes answer body" do
        patch :update, id: @answer,  answer: { body: "change to this", question_id: @question.id, user_id: @user.id }
        @answer.reload
        @answer.body.should eq("change to this")
      end
    end

    context "invalid attributes" do
      it "shows error message" do
        patch :update, id: @answer, answer: { body: "", question_id: @question.id, user_id: @user.id }
        @answer.reload
        expect(flash[:error]).to have_content("Answer field cannot be empty")
      end
    end
  end

  describe "delete #destroy" do
    before(:each) {
        log_me_in
        @answer = create(:answer)
    }

    it "deletes answer" do
      expect {
      delete :destroy, id: @answer
      }.to change(Answer,:count).by(-1)
    end

    it "redirects to question show page" do
      delete :destroy, id: @answer
      response.should redirect_to question_path(@answer.question)
    end
  end
end


require "rails_helper"

describe ResponsesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:@question) { create(:question) }
  let(:response_attr) { attributes_for(:response) }

  # describe "GET #new" do
  # end

  # describe "POST #create" do
  #   context "valid attributes" do
  #     it "creates new response" do
  #       log_me_in
  #       expect {
  #         post :create, response: { body: response[:body], respondable_id: @question.id, respondable_type: @question.class, user_id: response[:user] }
  #       }.to change(Response,:count).by(1)
  #     end
  #   end

  #   context "invalid attributes" do
  #     it "does not create response if field empty" do
  #       log_me_in
  #       expect {
  #         post :create, response: { body: "", respondable_id: @question.id, respondable_type: @question.class, user_id: response[:user] }
  #         }.to_not change(Response,:count)
  #     end
  #   end
  # end

  describe "GET #edit" do

    it "renders edit page" do
      log_me_in
      get :edit
      response.should render_template :edit
    end

  end

end

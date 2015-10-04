require "rails_helper"

describe ResponsesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:response_attr) { attributes_for(:response) }
  let(:create_response) {
    @question = create(:question)
    @test_response = Response.create(body: response_attr[:body], respondable_id: @question.id, respondable_type: @question.class, user_id: @user.id)

  }


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
      create_response
      get :edit, id: @test_response
      response.should render_template :edit
    end
  end

  describe "PATCH #update" do
    context "valid attributes" do

      it "changes response attributes" do
        log_me_in
        create_response
        patch :update, id: @test_response, response: { body: "change to this" }
        @test_response.reload
        @test_response.body.should eq("change to this")
      end

      it "redirects to updated page with changed response" do
        log_me_in
        create_response
        patch :update, id: @test_response, response: { body: "change to this" }
        response.should redirect_to question_path(@question)
      end
    end
  end

end
# { body: "update me", respondable_id: @question.id, respondable_type: @question.class, user_id: @user.id }
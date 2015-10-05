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


  describe "GET #new" do

    it "renders the new template" do
      log_me_in
      new_question = create(:question)
      get :new, question_id: new_question.id
      expect(response).to render_template("new")
    end
  end

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
      before(:each) {
        log_me_in
        create_response
      }

      it "changes response attributes" do
        patch :update, id: @test_response, response: { body: "change to this" }
        @test_response.reload
        @test_response.body.should eq("change to this")
      end

      it "redirects when successful" do
        patch :update, id: @test_response, response: { body: "change to this" }
        response.should redirect_to question_path(@question)
      end
    end

    context "invalid attributes" do
      before(:each) {
        log_me_in
        create_response
      }

      it "shows error message if empty" do
        patch :update, id: @test_response, response: { body: "" }
        @test_response.reload
        expect(flash[:error]).to have_content("Response field cannot be empty")
      end

      it "does not change response attributes" do
        patch :update, id: @test_response, response: { body: "" }
        @test_response.reload
        @test_response.body.should_not eq("")
      end

      it "not redirect to question page" do
        patch :update, id: @test_response, response: { body: "" }
        expect(response).to redirect_to edit_response_path(@test_response)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) {
      log_me_in
      create_response
    }

    it "deletes response" do
      expect {
        delete :destroy, id: @test_response
        }.to change(Response,:count).by(-1)
    end
  end

end

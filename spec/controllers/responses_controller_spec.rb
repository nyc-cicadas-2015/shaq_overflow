require "rails_helper"

describe ResponsesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
  }
  let(:response_attr) { attributes_for(:response) }
  let(:create_question) { @question = create(:question) }
  let(:create_answer) { @answer = create(:answer)}
  let(:create_response) {
    @test_response = Response.create(body: response_attr[:body], respondable_id: @question.id, respondable_type: @question.class, user_id: @user.id)
  }


  describe "GET #new" do
    it "renders new response template for question" do
      log_me_in
      create_question
      get :new, question_id: @question.id
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    before(:each) {
      log_me_in
      create_question
    }
    context "valid attributes" do
      it "creates new response for question" do
        expect {
          post :create, question_id: @question.id, response: { body: response_attr[:body], respondable_id: @question.id, respondable_type: @question.class, user_id: @user.id }
        }.to change(Response,:count).by(1)
      end
    end

    context "invalid attributes" do
      it "does not create response if field empty" do
        expect {
          post :create, question_id: @question.id, response: { body: "", respondable_id: @question.id, respondable_type: @question.class, user_id: @user.id }
          }.to_not change(Response,:count)
      end
    end
  end

  describe "GET #edit" do
    it "renders edit page" do
      log_me_in
      create_question
      create_response
      get :edit, id: @test_response
      response.should render_template :edit
    end
  end

  describe "PATCH #update" do
    context "valid attributes" do
      before(:each) {
        log_me_in
        create_question
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
        create_question
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
      create_question
      create_response
    }

    it "deletes response" do
      expect {
        delete :destroy, id: @test_response
        }.to change(Response,:count).by(-1)
    end
  end

end

require 'rails_helper'

describe QuestionsController do

  let(:login_page){LoginPageHelper.new}

  describe "GET index" do
    it "assigns @questions" do
      question = create(:question)
      get :index
      expect(assigns(:questions)).to eq([question])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET show" do
    it "renders the show template" do
      question = create(:question)
      get :show, id: question.id
      expect(response).to render_template("show")
    end
  end

  describe "POST create" do

    before(:each) {
      @user = create(:user)
      session[:user_id] = @user.id
    }

    context "with valid attributes" do
      it "saves the new contact in the database" do
        expect{
          post :create, question:attributes_for(:question)
          }.to change(Question,:count).by(1)
        end
      end

      context "with invalid attributes" do
        it "redirects to same page with flash message" do
          post :create, question: {title:"", body:""}
          expect(flash[:input]).to have_content("Please input information")
        end
      end
    end

    describe "PUT update and DELETE destroy" do
     before(:each) {
      @user = create(:user)
      session[:user_id] = @user.id
      @question = create(:question)
    }

    context "valid attributes" do

      it "changes @question's attributes" do
        put :update, id: @question,
        question: attributes_for(:question, title: "Updated title", body: "Updated body", user_id: @user.id)
        @question.reload
        @question.title.should eq("Updated title")
        @question.body.should eq("Updated body")
      end
    end

    context "invalid attributes" do
      it "shows a flash message telling you to input info" do
        put :update, id: @question,
        question: attributes_for(:question, title: "", body: "", user_id: @user.id)
        @question.reload
        expect(flash[:input]).to have_content("Please input information")
      end
    end

    it "deletes the contact" do
      expect{
        delete :destroy, id: @question
        }.to change(Question,:count).by(-1)
      end
    end

end
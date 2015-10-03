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
   context "with valid attributes" do
    it "saves the new contact in the database" do
        expect{
        user = create(:user)
        session[:user_id] = user.id
        post :create, question:attributes_for(:question)
        }.to change(Question,:count).by(1)
      end
    end
  end


end
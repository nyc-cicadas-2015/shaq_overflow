require 'rails_helper'

describe SessionsController do
	describe "POST #create" do

		describe "When succesful" do
			before(:each) {
        @user = create(:user) #Why is this @user and not user?  It stops working if I do it otherwise
        post :create, session: { username: user[:username], password: user[:password] }
      }
      let(:user) { attributes_for(:user) }

      it "redirects homepage" do 
      	expect(response).to redirect_to(root_path)
      end

      it "sets a session" do 
      	expect(session).to have_key(:user_id)
      end

      it "sets session to the user_id" do
      	expect(session[:user_id]).to eq(@user.id)
      end

      it "expect a confirmation flash message" do
      	expect(flash[:message]).to have_content "You succesfully logged in"
      end

		end

		describe "When unsuccesful" do

		end
	end
end
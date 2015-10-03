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

      it "expects a message flash" do
        expect(flash[:message]).to have_content "You succesfully logged in"
      end
    end

    describe "When unsuccesful" do
      before(:each){
        post :create, session: { username: 'nil', password: 'nil' }
      }

      it "redirect to login page" do 
        expect(response).to redirect_to(login_path)
      end

      it "no session is set" do
        expect(session[:user_id]).to be_nil
      end

      it "expects an error flash" do
      	expect(flash[:error]).to have_content "User not found, please try logging in again"
      end
		end
	end
  describe "DELETE #destroy" do
    it "redirects homepage" do 
      session[:user_id] = 1
      delete :destroy
      expect(response).to redirect_to(root_path)
    end

    it "removes the session[:user_id]" do
      session[:user_id] = 1
      delete :destroy
      expect(session[:user_id]).to be_nil
    end
  end
end


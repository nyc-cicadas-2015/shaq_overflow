require 'rails_helper'

describe SessionsController do
	describe "POST #create" do

		describe "When succesful" do
			before(:each) {
        user = create(:user)
        post :create, session: { username: user[:username], password: user[:password] }
      }
      let(:user) { attributes_for(:user) }

      it "redirects homepage" do 
      	expect(response).to redirect_to(root_path)
      end
      # succesful login redirect path built

		end

		describe "When unsuccesful" do

		end
	end
end
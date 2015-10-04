require "rails_helper"

describe ResponsesController do
  let(:log_me_in) {
    @user = create(:user)
    session[:user_id] = @user.id
    @question = create(:question)
  }

  describe "POST #create" do
    context "valid attributes" do
      it "creates new response" do
        expect {
          post :create, response: create(:response)
        }.to change(Response,:count).by(1)
      end
    end
  end

end
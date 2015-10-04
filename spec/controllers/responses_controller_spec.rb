# require "rails_helper"

# describe ResponsesController do
#   let(:log_me_in) {
#     @user = create(:user)
#     session[:user_id] = @user.id
#     @question = create(:question)
#   }
#   let(:response_attr) { attributes_for(:response) }

#   describe "POST #create" do
#     context "valid attributes" do
#       it "creates new response" do
#         log_me_in
#         expect {
#           post :create, response: { body: response[:body], respondable_id: @question.id, respondable_type: @question.class, user_id: response[:user] }
#         }.to change(Response,:count).by(1)
#       end
#     end
#   end

# end
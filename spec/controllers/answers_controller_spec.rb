# require "rails_helper"

# describe AnswersController do
#   let(:login_page) { LoginPageHelper.new }

#   describe "GET #create" do
#     describe "When successful" do
#       before(:each) {
#         @user = create(:user)
#         session[:user_id] = @user.id
#       }
#       let(:question_attr) { attributes_for(:question) }
#       let(:answer_attr) { attributes_for(:answer) }

#       it "posts answer onto question page" do
#         expect{
#           question = create(:question)
#           post :create, answer: attributes_for(:answer)
#           }.to change(Answer,:count).by(1)
#         end

#       end
#     end
#   end


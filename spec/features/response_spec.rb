require 'rails_helper'

describe 'response form' do
  before(:each){
    create_question
    log_me_in
  }

  let(:create_question) {create(:question)}
  let(:log_me_in) {
    user = create(:user)
    visit login_path
    within("#login") do
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button 'Login'
    end
  }

   let(:response_attr){attributes_for(:response)}

  it "to see if it is on the page" do
    create_question
    visit question_path(question)
    within("new_response") do
      fill_in 'response_body', :with => response_attr[:]

  end


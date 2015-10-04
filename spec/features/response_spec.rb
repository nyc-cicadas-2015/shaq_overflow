require 'rails_helper'

describe 'response form' do
  before(:each){
    log_me_in
  }

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
    question = create(:question)
    visit question_path(question)
    click_link "Comment"
    within("#new_response") do
      fill_in 'response_body', :with => response_attr[:body]
    end
    click_button 'Post response!'
    expect(page).to have_content response_attr[:body]
  end
end

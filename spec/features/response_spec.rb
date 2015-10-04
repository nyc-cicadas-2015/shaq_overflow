require 'rails_helper'

describe 'response page' do
  before(:each){
    log_me_in
  }

  let(:log_me_in) {
    @user = create(:user)
    visit login_path
    within("#login") do
      fill_in 'Username', :with => @user.username
      fill_in 'Password', :with => @user.password
      click_button 'Login'
    end
  }
  let(:response_attr){attributes_for(:response)}

  it "to see if new response form is on correct page" do
    question = create(:question)
    visit question_path(question)
    click_link "Comment"
    expect(page).to have_content 'Create a new response'
  end

  it "redirects to same page with no input" do
    question = create(:question)
    visit question_path(question)
    click_link "Comment"
    click_button 'Post response!'
    expect(page).to have_content "Response field cannot be empty"
  end


  it "to see if we can create a response" do
    question = create(:question)
    visit question_path(question)
    click_link "Comment"
    within("#new_response") do
      fill_in 'response_body', :with => response_attr[:body]
    end
    click_button 'Post response!'
    expect(page).to have_content response_attr[:body]
  end

it "see if we can reach edit form" do
  question = create(:question)
  visit question_path(question)
  response = Response.create(respondable_id: question.id, respondable_type: "Question",user_id: @user.id, body:"Test edit form" )
  visit edit_response_path(response)
  expect(page). to have_content "Edit your response"
end


it "see if response changes are made" do
  question = create(:question)
  visit question_path(question)

end


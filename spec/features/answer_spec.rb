require 'rails_helper'

describe "answer box" do
  let!(:question) { create(:question) }
  let(:answer_attr) { attributes_for(:answer) }
  let(:log_me_in) {
    user = create(:user)
    visit login_path
    within("#login") do
      fill_in 'Username', :with => user[:username]
      fill_in 'Password', :with => user[:password]
      click_button 'Login'
    end
  }

  it "can create answer to question" do
    log_me_in
    visit question_path(question)
    within("#new_answer") do
      fill_in 'answer_body', :with => answer_attr[:body]
    end
    click_button 'Post answer'
    expect(page).to have_content answer_attr[:body]
  end

  it "does not submit empty answer" do
    log_me_in
    visit question_path(question)
    within("#new_answer") do
      fill_in 'answer_body', :with => nil
    end
    click_button 'Post answer'
    expect(page).to have_content("Answer field cannot be empty")
  end

  it "does not submit answer if user not logged in" do
    visit question_path(question)
    within("#new_answer") do
      fill_in 'answer_body', :with => "this shouldn't show up!"
    end
    click_button 'Post answer'
    expect(question_path(question)).to_not have_content("this shouldn't show up!")
  end

end
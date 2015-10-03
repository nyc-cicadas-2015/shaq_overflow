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
    fill_in 'body', :with => answer_attr[:body]
    click_button 'Post answer'
    expect(page).to have_content answer.body
  end

end
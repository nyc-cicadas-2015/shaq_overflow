require 'rails_helper'

describe "question index page" do
  let!(:question) { create(:question) }
  let!(:questions) { [question, create(:question)] }

  it "show all questions on questions page" do
    visit root_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end
end

describe ' a new question page' do

 let(:question_attr){attributes_for(:question)}
 let(:user){attributes_for(:user)}


 let(:log_me_in) {
   user = create(:user)
   visit login_path
   within("#login") do
    fill_in 'Username', :with => user[:username]
    fill_in 'Password', :with => user[:password]
    click_button 'Login'
  end
}


it 'see if question form exists on page' do
  visit root_path
  click_link("Ask question")
  expect(page).to have_content ("Create new question")
end

it 'see if we can create a question' do
  log_me_in
  visit root_path
  click_link("Ask question")
  fill_in 'Body', :with => question_attr[:body]
  fill_in 'Title', :with => question_attr[:title]
  click_button('Submit')
  expect(page).to have_content question_attr[:title]
end
end

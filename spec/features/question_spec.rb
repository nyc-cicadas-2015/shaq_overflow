require 'rails_helper'

describe "question index page" do
  let!(:question) { create(:question) }
  let!(:questions) { [question, create(:question)] }

  it "shows all questions on page" do
    visit root_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end

describe ' a new question page' do

 let(:question_attr){attributes_for(:question)}

 let(:log_me_in) {
   @user = create(:user)
   visit login_path
   within("#login") do
    fill_in 'Username', :with => @user.username
    fill_in 'Password', :with => @user.password
    click_button 'Login'
  end
}

 let(:create_question) {
  log_me_in
  question = create(:question)
  question.update_attributes(user_id: @user.id)
 }


  it "links to correct question's pages" do
    visit root_path
    click_on question.title
    expect(current_path).to eq question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to_not have_content questions.last.title
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

  it 'to change its information' do
      create_question
      visit question_path(question)
      click_on "Edit question"
      fill_in "Title", :with => "Test"
      fill_in "Body", :with => "Is working"
      click_button "Submit"
      expect(page).to have_content "Test"
  end


end

describe 'question show page' do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  it 'shows question' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  it 'should show link to add response to question' do
    visit question_path(question)
    expect(page).to have_link("add a response")
  end

  it 'should show button to add answer' do
    visit question_path(question)
    expect(page).to have_button("Post answer")
  end

  it 'should show answers related to question' do
    visit question_path(question)
    question.answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  # xit 'should show tags related to question' do
  # end

  # xit 'should show votes for question' do
  # end

  # xit 'should show votes for answer' do
  # end

  # xit 'should show votes for response' do
  # end
end


describe ' a new question page' do
  it 'see if question form exists on page' do
    visit root_path
    click_link("Ask question")
    expect(page).to have_content ("Create new question")
  end

end
end





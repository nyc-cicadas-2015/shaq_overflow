require 'rails_helper'

describe "answers" do
  let!(:question) { create(:question) }
  let(:answer_attr) { attributes_for(:answer) }
  let(:log_me_in) {
    user = create(:user)
    visit login_path
    within("#login") do
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button 'Login'
    end
  }

  describe "create answers" do
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
        fill_in 'answer_body', :with => ""
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
      ## Check your expectations here!
      expect(question_path(question)).to_not have_content("this shouldn't show up!")
    end
  end

  describe "edit answer" do
    before :each do
      log_me_in
      visit question_path(question)
      within("#new_answer") do
        fill_in 'answer_body', :with => "edit me"
      end
      click_button 'Post answer'
    end

    it "shows edit box" do
      visit question_path(question)
      click_link "Edit answer"
      expect(page).to have_content("Edit your answer")
    end

    it "updates answer" do
      visit question_path(question)
      click_link "Edit answer"
      fill_in "answer_body", :with => "Updated answer"
      click_button "Update answer"
      expect(page).to have_content("Updated answer")
    end
  end

  describe "delete answer" do
    it "is no longer on question page" do
      log_me_in
      visit question_path(question)
      within("#new_answer") do
        fill_in 'answer_body', :with => "delete me"
      end
      click_button 'Post answer'
      visit question_path(question)
      click_link 'Delete answer'
      expect(page).to_not have_content("delete me")
    end
  end
end

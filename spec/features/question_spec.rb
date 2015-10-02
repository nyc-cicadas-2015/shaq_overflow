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
  it 'see if question form exists on page' do
    visit root_path
    click_link("Ask question")
    expect(page).to have_content ("Create new question")
  end


end

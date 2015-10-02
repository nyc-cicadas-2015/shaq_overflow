require 'rails_helper'

describe "question" do
  it "Sample test" do
    expect(1).to eq(1)
  end
end

describe ' a new question page' do
  it 'see if question form exists on page' do
    visit root_path
    click_link("Ask question")
    expect(page).to have_content ("Create a question")
  end


end

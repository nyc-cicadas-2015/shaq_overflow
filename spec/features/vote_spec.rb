require 'rails_helper'

describe 'Question Voting process' do
	let(:log_me_in) {
    user = create(:user)
    visit login_path
    within("#login") do
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
      click_button 'Login'
    end
  }
	describe "where user is NOT logged in" do
		it "to not see an upvote button" do
			visit root_path
	  	expect(page).to have_no_button "Upvote"
		end
	end

	describe "where user IS logged in" do
	  it "to see upvote button on page" do
	  	log_me_in
	  	question = create(:question)
	  	visit root_path
	  	expect(page).to have_button "Upvote"
	  end

	  it "will display flash telling user they upvoted if havent voted" do
	  	log_me_in
	  	question = create(:question)
	  	visit root_path
	  	click_button "Upvote"
	  	expect(page).to have_content("Thanks for liking the question")
	  end
	end

	describe 'where user has NOT previously voted' do
	end
	# describe 'that HAS previously voted' do
	# end
end
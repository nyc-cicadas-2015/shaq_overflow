require 'rails_helper'

describe 'Question Voting process' do
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
  it "to see upvote button on page" do
  	question = create(:question)
  	visit root_path
  	expect(page).to have_button "Upvote"
  end

	# describe 'where user has NOT previously voted' do
	# end
	# describe 'that HAS previously voted' do
	# end
end
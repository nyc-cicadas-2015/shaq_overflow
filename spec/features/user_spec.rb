require 'rails_helper'

describe 'Logging in Process' do
	let(:log_me_in) {
  	user = create(:user)
	  visit login_path
	  within("#login") do
	    fill_in 'Username', :with => user[:username]
	    fill_in 'Password', :with => user[:password]
	    click_button 'Login'
  	end
	}

  describe "If user is not logged in" do
    it 'should have a sign up link' do
      visit root_path
      expect(page).to have_content('Sign Up')
      expect(page).to have_content('Login')
    end
  end

  describe "if user is logged in" do
    it 'should have a sign up link' do
      log_me_in
      expect(page).to have_content('Create Post')
      expect(page).to have_content('Logout')
    end

    it "should log me out" do
      log_me_in
      click_link 'Logout'
      expect(page).to have_content('Sign Up')
      expect(page).to have_content('Login')
    end
  end
end

describe "Sign Up Process" do

  it "links to the right signup page" do 
    visit root_path
    click_link 'Sign Up'
    expect(page).to have_content("Please Register below")
    expect(page).to have_field("Name")
    expect(page).to have_field("Username")
    expect(page).to have_field("Password")
  end

  it "see if guest can register" do 
    visit root_path
  end
end



require 'rails_helper'

describe 'Logging in Process' do
	let(:log_me_in) {
  	user = create(:user)
	  visit login_path
	  within("#login") do
	    fill_in 'Username', :with => user.username
	    fill_in 'Password', :with => user.password
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
  let(:user_attr){attributes_for(:user)}
  describe "Valid user" do 
    it "links to the right signup page" do 
      visit root_path
      click_link 'Sign Up'
      expect(page).to have_content("Please Register below")
      expect(page).to have_field("Name")
      expect(page).to have_field("Username")
      expect(page).to have_field("Password")
    end

    it "Register will redirect properly" do 
      visit root_path
      click_link 'Sign Up'
      fill_in "Name", :with => user_attr[:name]
      fill_in "Username", :with => user_attr[:username]
      fill_in "Password", :with => user_attr[:password]
      click_button("Register")
      expect(page).to have_content user_attr[:name]
    end
  end

  describe "Invalid user" do
    it "see if guest can register" do 
      visit root_path
      click_link 'Sign Up'
      fill_in "Name", :with => nil
      fill_in "Username", :with => nil
      fill_in "Password", :with => nil
      click_button("Register")
      expect(page).to have_content("Invalid registration field")
    end
  end
end

describe "View User Index" do
  it "see if guest can see a user in database" do
    user1 = create(:new_user)
    user2 = create(:new_user)
    visit root_path
    click_link 'Users'
    expect(page).to have_content user1.username
    expect(page).to have_content user2.username
  end
  it "allows users to see other user's index page through links" do
    user1 = create(:new_user)
    user2 = create(:new_user)
    visit root_path
    click_link 'Users'
    click_link user1.username
    # click_link user_path(user1)
    # expect(page).to have_content user1.username
  end
end


describe 'Creating a user' do
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
      visit root_url
      expect(page).to have_content('Sign Up')
      expect(page).to have_content('Login')
    end
  end

  describe "If user is Logged In" do
    it 'should have a sign up link' do
    	log_me_in
      visit root_url
      expect(page).to have_content('Create Post')
      expect(page).to have_content('Logout')
    end
  end
end
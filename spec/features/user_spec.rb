describe 'Creating a user' do  
  describe "If user is not logged in" do
    it 'should have a sign up link' do
      visit root_url
      expect(page).to have_content('Sign Up')
    end

    it 'should have a Login link' do
      visit root_url
      expect(page).to have_content('Login')
    end
  end
end
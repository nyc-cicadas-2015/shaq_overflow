describe 'Creating a user' do
  let(:user_attrs) { attributes_for(:user) }
  
  describe "If user is not logged in"
    it 'should have a sign up link' do
      visit root_url
      expect(page).to have_content('Sign Up')
    end

    # it 'should bring you to the sign up page' do
    #   visit root_url
    #   click_link 'Sign Up'
    #   expect(current_path).to eq new_user_path
    # end
  end

  # it 'should bring you to the sign up page' do
  #   visit root_url
  #   click_link 'Sign Up'
  #   expect(current_path).to eq new_user_path
  # end

  # it 'should let you create a user' do
  #   visit new_user_path

  #   fill_in 'user_username', with: user_attrs[:username]
  #   fill_in 'user_password', with: user_attrs[:password]
  #   fill_in 'user_password_confirmation', with: user_attrs[:password]
  #   click_button 'Sign Up'

  #   expect(page).to have_content 'User was successfully created'
  # end
end
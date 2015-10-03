class LoginPageHelper
  include Capybara::DSL

  def visit_page
    visit '/login'
    self
  end

  def login user
    within("#login") do
      fill_in 'user_username', :with => user[:username]
      fill_in 'user_password', :with => user[:password]
    end
    click_button 'Login'
    self
  end
end
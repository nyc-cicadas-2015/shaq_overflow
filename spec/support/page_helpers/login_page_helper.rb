class LoginPageHelper
  include Capybara::DSL

  def visit_page
    visit '/login'
    self
  end

  def login user
    within("#login") do
      fill_in 'Username', :with => user.username
      fill_in 'Password', :with => user.password
    end
    click_button 'Login'
    self
  end
end
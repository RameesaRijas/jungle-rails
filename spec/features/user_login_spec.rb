require 'rails_helper'

RSpec.feature "ProductDetails",  type: :feature, js: true do
  before :each do
      User.create!(
        first_name: 'Alice',
        last_name: 'Test',
        email: 'Alice90@test.com',
        password: 'password',
        password_confirmation: 'password'  
      )
  end

  scenario 'User login' do
    visit login_path
  
    expect(page).to have_content('Login')
    fill_in 'email', with: 'Alice90@test.com'
    fill_in 'password', with: 'password'
    click_button "Submit"
    expect(page).to have_content('Hi Alice!')
    save_screenshot "user_auth.png"
  end
end

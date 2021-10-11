require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  before do
    @user = User.first_or_create!(email: 'demoo@test.com', password: "password")
    visit new_user_session_path
  end

  scenario "User sign in successfully" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Log in"

    expect(page).to have_current_path '/users/sign_in'
  end
end
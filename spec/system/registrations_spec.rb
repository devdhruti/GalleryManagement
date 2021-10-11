require 'rails_helper'

RSpec.describe "Registrations", type: :system do

  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 6) }

  before do
    visit new_user_registration_path
  end

  scenario "User Sign up successfully" do
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Sign up"
    expect(page).to have_current_path '/users'
  end
end

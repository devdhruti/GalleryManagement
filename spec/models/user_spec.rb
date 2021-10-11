require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.first_or_create!(email: "demo@example.com", password: "paswrd", password_confirmation: "paswrd")

  it "ensure email presence" do
    user.email = ""
    expect(user).to_not be_valid
    user.email = "demo@example.com"
    expect(user).to be_valid
  end

  it "ensure password presence" do
    user.password = ""
    expect(user).to_not be_valid
    user.password = "passwrd"
    expect(user).to be_valid
  end

  it "ensure confirm password presence" do
    user.password_confirmation = ""
    expect(user).to_not be_valid
    user.password_confirmation = "passwrd"
    expect(user).to be_valid
  end

  it "ensure password presence" do
    user.password = ""
    expect(user).to_not be_valid
    user.password = "passwrd"
    expect(user).to be_valid
  end

  it "password has minimum 6 characters" do
    user.password = "abc"
    expect(user).to_not be_valid
    user.password = "passwrd"
    expect(user).to be_valid
  end

  it "email should be valid " do
    %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com].each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
    end   
    user.email = "demo@example.com"
    expect(user).to be_valid
  end
end

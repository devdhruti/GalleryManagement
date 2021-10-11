require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  user = User.first_or_create!(email: 'demoo@test.com', password: "password")

  it "user signed out successfully" do

    sign_out user
    get root_path
    expect(response).not_to redirect_to("/users/sign_in")
    expect(response).to have_http_status(200)
  end
  
end
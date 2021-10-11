require 'rails_helper'

RSpec.describe Photo, type: :model do
  user = User.first_or_create!(email: "demo@example.com", password: "paswrd", password_confirmation: "paswrd")
  photo = Photo.new(user_id: user.id, image_file_name: "1.png", image_content_type: "image/png")

  it "user must exist" do
    photo.user_id = ""
    expect(photo).to_not be_valid

    photo.user_id = user.id
    expect(photo).to be_valid
  end

  it "ensure image presence" do
    photo.image_file_name = ""
    expect(photo).to_not be_valid

    photo.image_file_name = "1.png"
    expect(photo).to be_valid
  end

  it "ensure image content type" do
    photo.image_content_type = "html"
    expect(photo).to_not be_valid

    photo.image_content_type = "image/png"
    expect(photo).to be_valid
  end

end

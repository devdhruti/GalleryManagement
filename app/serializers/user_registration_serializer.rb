class UserRegistrationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :created_at, :updated_at, :confirmation_token
end

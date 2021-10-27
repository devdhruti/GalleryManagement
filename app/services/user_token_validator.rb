class UserTokenValidator
  class ParameterNotFound < StandardError; end
  class TokenNotFound < StandardError; end
  class UserNotFound < StandardError; end

  attr_reader :user, :user_token

  def validate!(token)
    raise ParameterNotFound, 'Token is missing' if token.blank?

    user_token = UserToken.find_or_initialize_by(token: token)
    raise TokenNotFound, 'Invalid user token' if user_token.blank?

    user = User.find_by id: user_token.user_id
    raise UserNotFound, 'User is missing' if user.blank?

    @user_token = user_token
    @user = user

    true
  end
end
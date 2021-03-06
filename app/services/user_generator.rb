class UserGenerator
  class ParameterNotFound < StandardError; end
  class DuplicateError < StandardError; end
  class InvalidCredentials < StandardError; end
  class ConfirmationError < StandardError; end
  
  attr_reader :user, :user_token
  
  def generate!(params)
    raise ParameterNotFound, 'Missing email' if params[:email].blank?
    
    user = User.find_by(email: params[:email].downcase)
    raise DuplicateError, 'This email already exists' if user.present?
    
    user = User.new(params)
    user.skip_confirmation_notification! 
    user.save!
    user.send_confirmation_instructions
    @user = user
    true
  end
  
  def validate!(params)
    raise ParameterNotFound, 'Missing email' if params[:email].blank?
    raise ParameterNotFound, 'Missing password' if params[:password].blank?
    
    user = User.find_by(email: params[:email].try(:downcase))
    raise ParameterNotFound, 'Email does not exist' if !user.present?
    raise InvalidCredentials, 'Invalid Password' unless user.valid_password?(params[:password])
    raise ConfirmationError, 'Your email address is not confirmed' unless user.confirmed?
    
    user_token = UserToken.find_or_initialize_by(user_id: user.id)
    raise DuplicateError, 'User already signed in' if !user_token.token.blank?
    user_token.token = generate_token

    user.save!
    user_token.save!

    @user = user
    @user_token = user_token
  end
  
  def confirmation!(params)
    raise ParameterNotFound, 'Missing confirmation token' if params[:confirmation_token].blank?

    user  = User.find_by(confirmation_token: params[:confirmation_token])
    raise DuplicateError, 'Invalid confirmation token' if user.blank?
    user =  User.confirm_by_token(params[:confirmation_token])
    user.confirmation_token = nil
    user.save!
    @user = user

    true
  end

  private
    
  def generate_token
    token_generator = SecureRandom.urlsafe_base64(128).tr('lIO0-', 'sxyzz')
    loop do
      token = token_generator
      break token unless UserToken.exists?(token: token)
    end
  end
end

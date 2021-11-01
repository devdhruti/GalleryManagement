module Api
  module V1
    class AuthenticatedController < BaseController
      class InvalidCredentials < StandardError; end
      before_action :authorize_user!

      def current_user
        @current_user
      end
    
      def current_user_token
        @current_user_token
      end
      
      def authorize_user!
        @valid_token = UserTokenValidator.new

        token = request.headers['HTTP_AUTHENTICATION_TOKEN'] || request.headers['Authentication_Token']

        @valid_token.validate!(token)
        @current_user = @valid_token.user
        @current_user_token = @valid_token.user_token
      end

      def validate!(params_user_id)
        raise InvalidCredentials, 'Invalid user' unless params_user_id == current_user.id
        true
      end

      def verify!(params_album_id)
        album = Album.find(params_album_id)
        raise InvalidCredentials, 'Invalid album for user' unless album.user_id == current_user.id
        true
      end
    end
  end
end

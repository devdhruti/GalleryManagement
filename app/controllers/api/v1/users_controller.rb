class Api::V1::UsersController < Api::V1::BaseController

  # GET /api/v1/users
  def index
    begin
      @users = User.order('created_at')

    rescue => e
      render_exception(e, 422) && return
    end
    render json: UserSerializer.new(@users).serializable_hash
  end
end

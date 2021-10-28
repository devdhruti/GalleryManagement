class Api::V1::AlbumsController < Api::V1::AuthenticatedController

  # GET /api/v1/albums
  def index
    authorize_user!

    begin
      @albums = current_user.albums.order('created_at')

    rescue => e
      render_exception(e, 422) && return
    end
    render json: AlbumSerializer.new(@albums).serializable_hash
  end

  # POST /api/v1/albums
  def create
    authorize_user!
    
    begin
      album = Album.create!(album_params.merge(user_id: current_user.id))

    rescue => e
      render_exception(e, 422) && return
    end
    json_response(AlbumSerializer.new(album).serializable_hash[:data][:attributes]) 
  end

  # DELETE /api/v1/albums/:id
  def destroy
    authorize_user!

    begin
      @album = Album.find(params[:id])
      validate!(@album.user_id)
      @album.destroy

    rescue => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end

  # GET /api/v1/albums/:id
  def show
    authorize_user!

    begin
      @album = Album.find(params[:id])
      validate!(@album.user_id)

    rescue => e
      render_exception(e, 422) && return
    end
    json_response(AlbumSerializer.new(@album).serializable_hash[:data][:attributes]) 
  end

  private
  def album_params
    params.require(:album).permit(:name)
  end
end

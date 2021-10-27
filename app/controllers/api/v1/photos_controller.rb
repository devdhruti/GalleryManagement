class Api::V1::PhotosController < Api::V1::AuthenticatedController
  
  # GET /api/v1/photos
  def index
    begin
      @photos = current_user.photos.order('created_at')

    rescue => e
      render_exception(e, 422) && return
    end
    render json: PhotoSerializer.new(@photos).serializable_hash
  end

  # POST /api/v1/photos
  def create
    authorize_user!
    
    begin
      photo = Photo.create!(photo_params)

    rescue => e
      render_exception(e, 422) && return
    end
    json_response(PhotoSerializer.new(photo).serializable_hash[:data][:attributes]) 
  end
  
  # DELETE /api/v1/photos/:id
  def destroy
    authorize_user!

    begin
      @photo = Photo.find(params[:id])
      @photo.destroy

    rescue => e
      render_exception(e, 422) && return
    end
    render json: { success: true, data: {}, errors: [] }, status: 200
  end
  
  # GET /api/v1/photos/:id
  def show
    authorize_user!

    begin
      @photo = Photo.find(params[:id])

    rescue => e
      render_exception(e, 422) && return
    end
    json_response(PhotoSerializer.new(@photo).serializable_hash[:data][:attributes]) 
  end
  
  private
  def photo_params
    params.require(:photo).permit(:image, :user_id, :album_id)
  end
end

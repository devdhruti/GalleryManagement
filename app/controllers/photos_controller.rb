class PhotosController < ApplicationController
  def index
    @photos = Photo.order('created_at')
  end

  def new
    @photo = Photo.new
    @albums = current_user.albums
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save 
      flash[:notice] = "Successfully added new photo!"
      redirect_to photos_path
    else
      
      redirect_to new_photo_path, alert: @photo.errors.full_messages.first
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      flash[:notice] = "Successfully deleted photo!"
      redirect_to photos_path
    else
      flash[:alert] = "Error deleting photo!"
    end
  end

  def show
    @photos = current_user.photos
    @photo = @photos.find(params[:id])

    @prev_photo = @photo.prev(@photos,@photo)
    @next_photo = @photo.next(@photos,@photo)
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image, :user_id, :album_id)
  end
end

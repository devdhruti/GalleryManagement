class PhotosController < ApplicationController

    def index
        @photos = Photo.order('created_at')
    end

    def new
        @photo = Photo.new
    end
 
    def create
        @photo = Photo.new(photo_params)
        if @photo.save
            flash[:notice] = "Successfully added new photo!"
            redirect_to photos_path
        else
            flash[:alert] = "Error adding new photo!"
            render :new
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
        @photo = Photo.find(params[:id])

        @prev_photo = @photo.prev
        @next_photo = @photo.next
    end
  
    private
  
    def photo_params
        params.require(:photo).permit(:title, :image, :user_id)
    end
end

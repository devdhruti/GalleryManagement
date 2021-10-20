class AlbumsController < ApplicationController
  def index
    @albums = Album.order('created_at')
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:notice] = "Successfully added new album!"
      redirect_to albums_path
    else
      flash[:alert] = "Error adding new album!"
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.destroy
      flash[:notice] = "Successfully deleted album!"
      redirect_to albums_path
    else
      flash[:alert] = "Error deleting album!"
    end
  end

  def show
    @albums = current_user.albums
    @album = @albums.find(params[:id])
  end

  private
  
  def album_params
    params.require(:album).permit(:name, :user_id)
  end
  
end

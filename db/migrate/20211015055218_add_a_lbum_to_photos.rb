class AddALbumToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :album, foreign_key: true
  end
end

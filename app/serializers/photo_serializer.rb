class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :image_file_name, :user_id, :album_id
end
  
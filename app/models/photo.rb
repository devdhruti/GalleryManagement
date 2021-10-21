class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album

  has_attached_file :image, styles: { large: "600*600", medium: "300*300", thumb: "150*150#"}
  validates :image, attachment_presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def prev(photos,photo)
    photos.where("photos.id < ?",photo.id).order('photos.id asc').last
  end

  def next(photos,photo)
    photos.where("photos.id > ?",photo.id).order('photos.id asc').first
  end

end

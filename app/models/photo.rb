class Photo < ApplicationRecord
  belongs_to :user

  has_attached_file :image, styles: { large: "600*600", medium: "300*300", thumb: "150*150#"}
  validates :image, attachment_presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def prev
    Photo.where("id < ?",id).last
  end

  def next
    Photo.where("id > ?",id).first
  end

end

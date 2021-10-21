class Album < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  validates :name, presence: true,  :uniqueness => {:scope=>:user_id}
end

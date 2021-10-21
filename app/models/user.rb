class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums, dependent: :destroy
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end

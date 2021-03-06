class User < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums, dependent: :destroy
  has_one :user_token, dependent: :destroy
  has_many :quotes, dependent: :destroy
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end

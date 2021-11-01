class Quote < ApplicationRecord
  belongs_to :user

  validates :quotes, presence: true
end

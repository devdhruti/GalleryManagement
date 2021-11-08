class Quote < ApplicationRecord
  belongs_to :user

  validates :quotes, presence: true

  include PgSearch::Model
  pg_search_scope :search, against: :quotes, using: {tsearch: {prefix: true}}
end

class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6 }
  validates_uniqueness_of :movie_id, scope: :list_id, message: "is already in this list"
end

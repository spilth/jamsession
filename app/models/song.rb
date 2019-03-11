class Song < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist }
  validates :artist, presence: true
  validates :body, presence: true
end

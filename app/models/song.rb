class Song < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :artist }
  validates :artist, presence: true
  validates :body, presence: true

  has_one_attached :pdf

  after_save do
    GeneratePdfJob.perform_later(self)
  end
end

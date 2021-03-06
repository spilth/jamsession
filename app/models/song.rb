class Song < ApplicationRecord
  enum difficulty: { beginner: 0, easy: 1, medium: 2, hard: 3 }

  validates :title, presence: true, uniqueness: true
  validates :artist, presence: true
  validates :body, presence: true

  has_one_attached :pdf

  has_and_belongs_to_many :songbooks

  before_save do
    self.path = title.parameterize
  end

  after_save do
    GenerateSongPdfJob.perform_later(self)
  end

  def to_param
    path
  end
end

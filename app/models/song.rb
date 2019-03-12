class Song < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :artist, presence: true
  validates :body, presence: true

  has_one_attached :pdf

  before_save do
    self.path = title.parameterize
  end

  after_save do
    GeneratePdfJob.perform_later(self)
  end

  def to_param
    path
  end
end

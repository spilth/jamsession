class Songbook < ApplicationRecord
  has_and_belongs_to_many :songs

  has_one_attached :table_of_contents
  has_one_attached :pdf

  before_save do
    self.path = name.parameterize
  end

  after_save do
    GenerateSongbookTocPdfJob.perform_later(self)
  end
end

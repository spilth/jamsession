class GenerateSongbookTocPdfJob < ApplicationJob
  queue_as :default

  def perform(songbook)
    url =  Rails.application.routes.url_helpers.table_of_contents_songbook_url(songbook, format: :pdf)
    pdf = open(url)

    songbook.table_of_contents.attach(io: pdf, filename: "#{songbook.name.parameterize}.toc.pdf")

    GenerateSongbookPdfJob.perform_later(songbook)
  end
end

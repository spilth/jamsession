class GenerateSongbookTocPdfJob < ApplicationJob
  queue_as :default

  def perform(songbook)
    songbook.update_column(:building, true)

    url =  Rails.application.routes.url_helpers.table_of_contents_songbook_url(songbook, format: :pdf)
    toc = open(url)
    songbook.table_of_contents.attach(io: toc, filename: "#{songbook.name.parameterize}.toc.pdf")

    url =  Rails.application.routes.url_helpers.blank_page_songbook_url(songbook, format: :pdf)
    blank = open(url)
    songbook.blank_page.attach(io: blank, filename: "#{songbook.name.parameterize}.blank.pdf")

    GenerateSongbookPdfJob.perform_later(songbook)
  end
end

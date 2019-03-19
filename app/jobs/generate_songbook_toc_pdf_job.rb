class GenerateSongbookTocPdfJob < ApplicationJob
  queue_as :default

  def perform(songbook)
    url =  Rails.application.routes.url_helpers.table_of_contents_songbook_url(songbook, format: :pdf)
    pdf = open(url)

    songbook.table_of_contents.attach(io: pdf, filename: "#{songbook.name.parameterize}.toc.pdf")

    # reader = PDF::Reader.new(pdf)
    # songbook.update_column(:page_count, reader.page_count)
    GenerateSongbookPdfJob.perform_later(songbook)
  end
end

class GenerateSongPdfJob < ApplicationJob
  queue_as :default

  def perform(song)
    song.update_column(:building, true)

    url = Rails.application.routes.url_helpers.song_url(song, format: :pdf)
    pdf = open(url)

    song.pdf.attach(io: pdf, filename: "#{song.title.parameterize}.pdf")
    
    reader = PDF::Reader.new(pdf)
    song.update_columns(page_count: reader.page_count, building: false)
  end
end

class GeneratePdfJob < ApplicationJob
  queue_as :default

  def perform(song)
    url =  Rails.application.routes.url_helpers.song_url(song, format: :pdf)
    song.pdf.attach(io: open(url), filename: "#{song.title.parameterize}.pdf")
  end
end

require 'net/http'

class GenerateSongbookPdfJob < ApplicationJob
  queue_as :default

  def perform(songbook)
    pdf = CombinePDF.new

    pdf << CombinePDF.parse(songbook.table_of_contents.download)

    songs = songbook.songs.all.order(:title)

    songs.each {|song| pdf << CombinePDF.parse(song.pdf.download)}

    pdf.number_pages(
        number_format: '%s',
        location: :bottom_right,
        margin_from_height: 5,
        font_size: 9
    )

    songbook.pdf.attach(io: StringIO.new(pdf.to_pdf), filename: "#{songbook.name.parameterize}.pdf")
  end
end

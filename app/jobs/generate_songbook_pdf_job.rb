require 'net/http'

class GenerateSongbookPdfJob < ApplicationJob
  queue_as :default

  def perform(songbook)
    pdf = CombinePDF.new

    blank_page = CombinePDF.parse(songbook.blank_page.download)

    pdf << CombinePDF.parse(songbook.table_of_contents.download)

    songs = songbook.songs.all.order(:title)

    songs.order(:title).each do |song|
      pdf << CombinePDF.parse(song.pdf.download)
      pdf << blank_page if song.page_count == 1
    end

    pdf.number_pages(
      number_format: '%s',
      location: :bottom_right,
      margin_from_height: 5,
      font_size: 9
    )

    songbook.pdf.attach(io: StringIO.new(pdf.to_pdf), filename: "#{songbook.name.parameterize}.pdf")
    songbook.update_column(:building, false)
  end
end

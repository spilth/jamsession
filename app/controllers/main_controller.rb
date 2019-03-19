class MainController < ApplicationController
  def index
    @songs = Song.all.order(:title)
    @songbooks = Songbook.all.order(:name)
  end
end

class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  # GET /songs
  # GET /songs.json
  def index
    @songs = Song.all
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    @song_pro = SongPro.parse(@song.body)
    @chords = @song_pro.sections.collect {|section| section.lines.collect {|line| line.parts.collect {|part| part.chord}}}.flatten.uniq.reject(&:empty?)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @song.title.parameterize,
               template: 'songs/show.html.erb',
               layout: 'pdf',
               page_size: 'letter',
               margin: {
                   top: '10mm',
                   bottom: '10mm',
                   left: '20mm',
                   right: '20mm'
               },
               print_media_type: true,
               dpi: 300,
               zoom: 0.80,
               low_quality: true
      end
    end
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html {redirect_to @song, notice: 'Song was successfully created.'}
        format.json {render :show, status: :created, location: @song}
      else
        format.html {render :new}
        format.json {render json: @song.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html {redirect_to @song, notice: 'Song was successfully updated.'}
        format.json {render :show, status: :ok, location: @song}
      else
        format.html {render :edit}
        format.json {render json: @song.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.html {redirect_to songs_url, notice: 'Song was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = Song.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def song_params
    params.require(:song).permit(:title, :artist, :body, :spotify_url)
  end
end

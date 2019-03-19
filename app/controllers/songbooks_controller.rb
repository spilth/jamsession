class SongbooksController < ApplicationController
  before_action :set_songbook, only: [:show, :table_of_contents, :edit, :update, :destroy]

  # GET /songbooks
  def index
    @songbooks = Songbook.all
  end

  # GET /songbooks/1
  def show
  end

  def table_of_contents
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @songbook.name.parameterize,
               template: 'songbooks/table_of_contents.html.erb',
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

  # GET /songbooks/new
  def new
    @songbook = Songbook.new
  end

  # GET /songbooks/1/edit
  def edit
  end

  # POST /songbooks
  def create
    @songbook = Songbook.new(songbook_params)

    if @songbook.save
      redirect_to @songbook, notice: 'Songbook was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /songbooks/1
  def update
    if @songbook.update(songbook_params)
      redirect_to @songbook, notice: 'Songbook was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /songbooks/1
  def destroy
    @songbook.destroy
    redirect_to songbooks_url, notice: 'Songbook was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_songbook
      @songbook = Songbook.includes(:songs).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def songbook_params
      params.require(:songbook).permit(:name, :description, song_ids: [])
    end
end

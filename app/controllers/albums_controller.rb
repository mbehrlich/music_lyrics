class AlbumsController < ApplicationController

  before_action :check_signedin

  def show
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      redirect_to :root
    end
  end

  def new
    @bands = Band.all
    @album = Album.new(band_id: params[:band_id])
  end

  def create
    @bands = Band.all
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      redirect_to :root
    else
      render :edit
    end
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      redirect_to :root
    else
      if @album.update(album_params)
        redirect_to album_url(@album)
      else
        flash.now[:errors] ||= []
        flash.now[:errors] += @album.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @album = Album.find_by(id: params[:id])
    if @album.nil?
      redirect_to :root
    else
      band = @album.band_id
      @album.destroy
      redirect_to band_url(band)
    end
  end

  def album_params
    params.require(:album).permit(:title, :album_type, :band_id)
  end

end

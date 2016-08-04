class BandsController < ApplicationController

  before_action :check_signedin
  
  def index
    @bands = Band.all
  end

  def show
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      redirect_to :root
    end
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      redirect_to :root
    else
      render :edit
    end
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      redirect_to :root
    else
      if @band.update(band_params)
        redirect_to band_url(@band)
      else
        flash.now[:errors] ||= []
        flash.now[:errors] += @band.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])
    if @band.nil?
      redirect_to :root
    else
      @band.destroy
      redirect_to :root
    end
  end

  def band_params
    params.require(:band).permit(:name)
  end

end

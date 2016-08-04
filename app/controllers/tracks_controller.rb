class TracksController < ApplicationController

    before_action :check_signedin

    def show
      @track = Track.find_by(id: params[:id])
      if @track.nil?
        redirect_to :root
      end
    end

    def new
      @albums = Album.all
      @track = Track.new(album_id: params[:album_id])
    end

    def create
      @track = Track.new(track_params)
      if @track.save
        redirect_to track_url(@track)
      else
        @albums = Album.all
        flash.now[:errors] ||= []
        flash.now[:errors] += @track.errors.full_messages
        render :new
      end
    end

    def edit
      @albums = Album.all
      @track = Track.find_by(id: params[:id])
      if @track.nil?
        redirect_to :root
      else
        render :edit
      end
    end

    def update
      @track = Track.find_by(id: params[:id])
      if @track.nil?
        redirect_to :root
      else
        if @track.update(track_params)
          redirect_to track_url(@track)
        else
          @albums = Album.all
          flash.now[:errors] ||= []
          flash.now[:errors] += @track.errors.full_messages
          render :edit
        end
      end
    end

    def destroy
      @track = Track.find_by(id: params[:id])
      if @track.nil?
        redirect_to :root
      else
        album = @track.album_id
        @track.destroy
        redirect_to album_url(album)
      end
    end

    def track_params
      params.require(:track).permit(:title, :track_type, :album_id, :lyrics)
    end


end

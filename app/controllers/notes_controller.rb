class NotesController < ApplicationController

  before_action :check_signedin

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      flash[:errors] ||= []
      flash[:errors] += @note.errors.full_messages
      redirect_to track_url(@note.track_id)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note.nil? || current_user.id != @note.user_id
      redirect_to :root
    else
      track = @note.track_id
      @note.destroy
      redirect_to track_url(track)
    end
  end

  def note_params
    params.require(:note).permit(:note, :track_id)
  end

end

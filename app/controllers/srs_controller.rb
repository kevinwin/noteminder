class SrsController < ApplicationController
  def index
    @note = Note.find(params[:id])
  end

  # update srs attributes
  def create
    @note = Note.find(params[:note_id])

    # resets values to non nil if they are nil
    # if (@note.easiness_factor == nil && @note.number_repetitions == nil)
    #   @note.reset_spaced_repetition_data
    # end

    # test without update_attributes method
    @note.update_attributes(:srs_update => params["note"]["srs_update"].to_i)
    @note.process_srs(@note.srs_update)
    @note.touch
  end

  private

  def note_params
      params.require(:note).permit(:id, :srs_update)
  end
end
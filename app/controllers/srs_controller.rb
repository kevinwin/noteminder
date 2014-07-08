class SrsController < ApplicationController
  def index
    @note = Note.find(params[:id])
  end

  # update srs attributes
  def create
    @note = Note.find(params[:id])
    # test without update_attributes method
    @note.process_recall_result(params["srs_update"].to_i)
  end

  private

  def note_params
      params.require(:note).permit(:id, :srs_update)
  end
end
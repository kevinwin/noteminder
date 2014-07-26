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

    # Handle when user clicks submit but forgets to click a radio button
    # if !params["note"]["srs_update"]?
    #   redirect_to 
    # end

    # test without update_attributes method
    @note.update_attributes(:srs_update => params["note"]["srs_update"].to_i)
    
    # updates srs attributes based on user feedback.
    @note.process_srs(@note.srs_update)

    # Demo line. Update the most recently created note so that next_repetition is set to today. 
    # After touch emails should be sent every minute.
   
    
    # Trigger for checking if Note should be sent after feedback
    @note.touch
  end

  private

  def note_params
      params.require(:note).permit(:id, :srs_update, note_id)
  end
end
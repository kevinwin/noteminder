class NotesController < ApplicationController

	def index
		@notes = Note.all
	end

	def new
		@note = Note.new
		
		# @user.decks.build
		# @user.decks.each {|deck| deck.notes.build}
	end

	def edit
		@note = Note.find(params[:id])
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
	end

	def create
			@note = Note.new(note_params)
		if @note.save
			redirect_to notes_path
		else
			render 'notes#new' 
		end

	end

	private

	def note_params
			params.require(:note).permit(:question, :answer)
	end


end
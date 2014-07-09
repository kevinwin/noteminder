class NotesController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create]

	def index
		@notes = Note.all
	end

	def new
		@note = Note.new
		set_deck
		# @user.decks.build
		# @user.decks.each {|deck| deck.notes.build}
	end

	def show
		@note = Note.find(params[:id])
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
			# initializes note with default srs attributes
			@note.update_attributes(:easiness_factor => 2.5, :number_repetitions => 0, :quality_of_last_recall => nil, :next_repetition => nil, :repetition_interval => nil, :last_studied => nil)
			# # are they creating a new deck, or adding to a preexisting deck? 
			# # create a new deck
			if params["note"]["deck_id"] == nil
				@deck = Deck.create()
				@deck.update_attributes(:title => params["deck_title"] ) 
				@deck.update_attributes(:user_id => current_user.id)
				@note.deck_id = @deck.id
			# add to an existing deck
			else 

			end

		if @note.save
			redirect_to notes_path, :alert => "Your note was successfully created."
		else
			set_deck
			render :new
		end

	end

	private

	def note_params
			params.require(:note).permit(:id, :question, :answer, :deck_id, :easiness_factor, :number_repetitions, :quality_of_last_recall, :next_repetition, :repetition_interval, :last_studied, :srs_update)
	end

	def set_deck
		@decks = Deck.where(:user_id => current_user.id)
	end



end
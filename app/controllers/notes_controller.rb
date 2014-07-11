class NotesController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create]

	def index
		@notes = Note.all
		
	end

	def new
		# flash[:notice] = "Note was successfully created"
		
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
				@deck = Deck.create(title: params["deck_title"], user_id: current_user.id)
				@note.deck_id = @deck.id
				
			# add to an existing deck
			else 

			end

		if @note.save
			flash[:success] = "Wahoo! You created a note."
			redirect_to :action => :new
		else
			set_deck
			flash[:error] = "Try again. Please enter all fields to create a note."
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
class DecksController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create, :index]

	def index
		@notes = Note.all.filter(params[:q])
		@decks = Deck.all.where(:user_id => current_user.id)
		@note = Note.new
	end

	def new
		@deck = Deck.new
	end

	def edit
		@decks = Deck.all.map { |p| [p.title, p.id]}
		@note = Note.find(params[:id])
		@notes = Note.all.map { |n| [n.question, n.answer] }
	end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy

		redirect_to decks_path
	end

	def create
			@deck = Deck.new(deck_params)
			@deck.user = current_user

		if @deck.save
			redirect_to decks_path
		else
			render 'users#new' # check if this works #
		end

	end

	private

	def deck_params
			params.require(:deck).permit(:title, :user_id)
	end

end
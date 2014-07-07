class DecksController < ApplicationController
	before_action :authenticate_user!, :only => [:new, :create]

	def index
		@decks = Deck.all
	end

	def new
		@deck = Deck.new
	end

	def edit
	end

	def destroy
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
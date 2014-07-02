class DecksController < ApplicationController

	def index
		@decks = Deck.all
	end

	def new
	end

	def edit
	end

	def destroy
	end

	def create
	end

end
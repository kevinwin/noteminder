class NotesController < ApplicationController

	def index
		@notes = Note.all
	end

	def new
		@note = Note.new
	end

	def edit
	end

	def destroy
	end

	def create
		
	end

end
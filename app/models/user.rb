class User < ActiveRecord::Base
	has_many :decks, :dependent => :destroy	
	validates_presence_of :email # come back to this and add error message (flash); seems to work
	accepts_nested_attributes_for :decks
end
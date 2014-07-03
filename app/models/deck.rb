class Deck < ActiveRecord::Base
	has_many :notes, :dependent => :destroy
	belongs_to :user
	accepts_nested_attributes_for :notes

end
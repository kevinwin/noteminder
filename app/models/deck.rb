class Deck < ActiveRecord::Base
	belongs_to :user
	has_many :notes, :dependent => :destroy
	# accepts_nested_attributes_for :notes
	validates :title, :presence => true

end
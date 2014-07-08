class Deck < ActiveRecord::Base
	belongs_to :user
	has_many :notes, :dependent => :destroy
	# accepts_nested_attributes_for :notes
	validates :title, :presence => true
  validates :title, uniqueness: {scope: :user_id}
  validates :user_id, :presence => true


end
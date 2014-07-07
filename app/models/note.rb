class Note < ActiveRecord::Base
	belongs_to :deck
	validates :question, :presence => true
	validates :answer, :presence => true
end
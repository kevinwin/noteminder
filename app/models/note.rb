class Note < ActiveRecord::Base
	belongs_to :deck
	validates :question, :presence => true
	validates :answer, :presence => true
  validates :deck_id, :presence => true
	after_create :send_note_created_email

	protected

	def send_note_created_email
    UserNotifier.note_created_email(self).deliver
	end
end
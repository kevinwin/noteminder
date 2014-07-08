require 'rufus-scheduler'

class Note < ActiveRecord::Base
  include SuperMemo::SM2 
	attr_accessor :easiness_factor, :number_repetitions, :quality_of_last_recall, :next_repetition, :repetition_interval, :last_studied
  belongs_to :deck
	validates :question, :presence => true
	validates :answer, :presence => true
  validates :deck_id, :presence => true
  validates :question, uniqueness: {:scope => :deck_id}
  validates :answer, uniqueness: {:scope => :deck_id}
	after_create :send_note_created_email

  
      


	protected

	def send_note_created_email
    # Sends an initial email confirming that a note has been created
    UserNotifier.note_created_email(self).deliver

    # Initializes the scheduler
    scheduler = Rufus::Scheduler.new

    #resets the note's spaced repetition data
    self.reset_spaced_repetition_data

    # checks if note is scheduled to recall. If so, deliver the note.
    # scheduler.every '1m', :last_at => Time.now + 1 * 3600 do
    #   if self.scheduled_to_recall?
    #     UserNotifier.note_created_email(self).deliver
      # end
  	# end
  end
end
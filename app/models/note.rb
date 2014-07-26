require 'rufus-scheduler'

class Note < ActiveRecord::Base
  include SuperMemo::SM2 
  # added attributes to model directly
	# attr_accessor :easiness_factor, :number_repetitions, :quality_of_last_recall, :next_repetition, :repetition_interval, :last_studied
  belongs_to :deck
	validates :question, :presence => true
	validates :answer, :presence => true
  validates :deck_id, :presence => true
  validates :question, uniqueness: {:scope => :deck_id}
  validates :answer, uniqueness: {:scope => :deck_id}
	after_create :send_note_created_email
  after_touch :send_noteminder

  def self.filter(query)
    return Note.all if query == nil || query == ""

    Note.all.where('question LIKE "%#{query}%"')
  end
	

    def process_srs(quality_of_recall)
    DBC.require(quality_of_recall >= 0)
    DBC.require(quality_of_recall <= 5)
    DBC.require(easiness_factor)
    DBC.require(number_repetitions)
      
    if quality_of_recall < 3
      self.update_attributes(:number_repetitions => 0)
      self.update_attributes(:repetition_interval => 0)
    else
      self.update_attributes(:easiness_factor => calculate_easiness_factor(easiness_factor, quality_of_recall))
    
      if quality_of_recall == 3
        self.update_attributes(:repetition_interval => 0)
      else
        self.update_attributes(:number_repetitions => (self.number_repetitions+1))

        case number_repetitions
        when 1
          self.update_attributes(:repetition_interval => 1)
        when 2
          self.update_attributes(:repetition_interval => 6)
        else
          self.update_attributes(:repetition_interval => self.repetition_interval * self.easiness_factor)
        end
      end
    end
    
    self.update_attributes(:next_repetition => Date.today + self.repetition_interval)
    self.update_attributes(:last_studied => Date.today)
  end


  protected




	def send_note_created_email
    #resets the note's spaced repetition data
    # self.reset_spaced_repetition_data

    # Sends an initial email confirming that a note has been created
    UserNotifier.note_created_email(self).deliver

  end

  def send_noteminder
    # Initializes the scheduler
    scheduler = Rufus::Scheduler.new

    #checks once-a-day if note is scheduled to recall. If so, deliver the note.
    # scheduler.every '1d' do#, :last_at => Time.now + 1 * 3600 do
    scheduler.every '1d' do
      if self.scheduled_to_recall?
        UserNotifier.noteminder(self).deliver
      end
    end
  end

end
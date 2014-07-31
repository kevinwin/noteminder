class UserNotifierWorker
  include Sidekiq::Worker

  def perform(note_id)
    #sends email
    note = Note.find(note_id)

  


  end
end

# Perform methods


def send_noteminder
  # Initializes the scheduler
  scheduler = Rufus::Scheduler.new

  #checks if note is scheduled to recall. If so, deliver the note.
  scheduler.every '1m' do#, :last_at => Time.now + 1 * 3600 do
    if self.scheduled_to_recall?
      UserNotifier.noteminder(self).deliver
    end
  end
end
class UserNotifierWorker
  include Sidekiq::Worker

  def perform(id)
    object = Note.find(id)
    interval = object.calculate_interval
    UserNotifier.delay_for(interval.days)noteminder(object.id)
  end
end


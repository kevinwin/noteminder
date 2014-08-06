HireFire::Resource.configure do |config|
  config.dyno(:all_worker) do
    HireFire::Macro::Sidekiq.queue
  end

  config.dyno(:mailer) do
    HireFire::Macro::Sidekiq.queue(:email)
  end

  config.dyno(:encoder) do
    HireFire::Macro::Sidekiq.queue(:encode)
  end

  config.dyno(:multi_queue) do
    HireFire::Macro::Sidekiq.queue(:foo, :bar, :baz)
  end
end
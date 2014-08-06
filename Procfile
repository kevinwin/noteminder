web: bundle exec unicorn_rails -p $PORT -c ./config/unicorn.rb
all_worker: bundle exec sidekiq -q list -q all -q queues -q here
mailer: bundle exec sidekiq -q email
encoder: bundle exec sidekiq -q encode
multi_queue: bundle exec sidekiq -q foo -q bar -q baz
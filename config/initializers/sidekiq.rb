
if ENV["RAILS_ENV"] == 'production'
  puts "Sidekiq initialized"
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://redis-za:6379/12' }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: 'redis://redis-za:6379/12' }
  end
end

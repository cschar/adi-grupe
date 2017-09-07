desc "Process new Lmarkers with rps game rules"
task :rps_game_logic_on_lmarkers => :environment do
  puts "applying rock/paper/scissors game logic to lmarkers"

  # will not log with bundle exec sidekiq
  # RpsWorker.new.perform

  #will show up with bundle exec sidekiq
  RpsWorker.perform_async()
  puts "done."
end
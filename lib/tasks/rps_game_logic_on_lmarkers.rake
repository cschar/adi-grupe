desc "Process new Lmarkers with rps game rules"
task :rps_game_logic_on_lmarkers2 => :environment do
  puts "applying rock/paper/scissors game logic to lmarkers"

  # will not log with bundle exec sidekiq
  #BUt works in prod....
  RpsWorker.new.perform

  # will show up with bundle exec sidekiq
  # but doesnt work in prod...
  #RpsWorker.perform_async()
  puts "done."
end
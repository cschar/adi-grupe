
#https://github.com/ffaker/ffaker/blob/master/REFERENCE.md
desc "gen items"
task gen_items: :environment do

  puts "genItems"
  15.times do
    Item.create(name: FFaker::Color.name + FFaker::Vehicle.make, user_id:1)
  end
end
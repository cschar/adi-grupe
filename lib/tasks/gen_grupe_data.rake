
task gen_grupe_data: :environment do

  Grupe.destroy_all
  Location.destroy_all

  ## possible grupe locations
  Location.create(name: "buck", latitude: 45.4161807, longitude: -75.6968755)
  Location.create(name: "buck2", latitude: 45.4116856, longitude: -75.6931154)

end

task gen_grupe_data: :environment do

  Grupe.destroy_all
  Location.destroy_all

  ## possible grupe locations
  Location.create(name: "buck", latitude: 45.4161807, longitude: -75.6968755)
  Location.create(name: "buck2", latitude: 45.4116856, longitude: -75.6931154)

  CSV.foreach("db/all-starbucks-ottawa.csv",
              headers: true,  :col_sep => ';' ) do |line|

    h = line.to_hash
    location = Location.create!(name: h["Name"], longitude: h["Longitude"], latitude: h["Latitude"])

    # [*rand(1..4)..3].each do |n|
    #   grupe = Grupe.create! name: FFaker::NameCN.name, location_id: location.id
    #   user = User.all.sample
    #   user.grupes << grupe
    # end

    # Location.create! line.to_hash
  end
end
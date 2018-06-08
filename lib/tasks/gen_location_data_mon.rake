
task gen_location_data_mon: :environment do

  CSV.foreach("db/all-starbucks-montreal.csv",
              headers: true,  :col_sep => ';' ) do |line|

    h = line.to_hash
    location = Location.create!(
      name: h["Name"] + " starbucks",
      ltype: "Starbucks",
      longitude: h["Longitude"],
      latitude: h["Latitude"])

  end
end
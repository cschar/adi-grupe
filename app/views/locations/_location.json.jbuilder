json.extract! location, :id, :name, :latitude, :longitude, :ltype, :created_at, :updated_at
json.url location_url(location, format: :json)

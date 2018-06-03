# https://github.com/rails/jbuilder

json.extract! grupe, :id, :name, :locked_in_at, :capacity,
             :creator_id, :location_id, :created_at, :updated_at
json.url grupe_url(grupe, format: :json)



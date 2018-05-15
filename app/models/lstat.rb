# == Schema Information
#
# Table name: lstats
#
#  id          :integer          not null, primary key
#  location_id :integer
#  data        :jsonb
#

class Lstat < ApplicationRecord

  # l = Lstat.first
  # l.data
  # >> ls.data #=> {"free"=>true, "name"=>"blue house", "tags"=>["coffee", "open space"]}
  # ls.data["free"] = false
  # ls.save
  # >> UPDATE "lstats" SET "data" = $1 WHERE "lstats"."id" = $2  [["data", "{\"free\":false,\"name\":\"blue house\",\"tags\":[\"coffee\",\"open space\"]}"], ["id", 1]]
  # Lstat.free.count
  scope :free, -> {
    where("lstats.data->>'free' = :true", true: "true")
  }
  
  scope :open_coffee_spots, -> {
      where("lstats.data->'tags' ? 'coffee' AND data->'tags' ? 'open space'")
  }

end

# == Schema Information
#
# Table name: locations
#
#  id              :integer          not null, primary key
#  name            :string
#  latitude        :float
#  longitude       :float
#  ltype           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  total_grupes    :integer          default(0)
#  recent_quest_id :integer
#  region          :text
#

class Location < ApplicationRecord
  has_many(:grupes)

  searchkick(locations: [:location])

  def search_data
    attributes.merge location: {lat: latitude, lon: longitude}
  end


  def my_tostring
    name + "  " + ["@" ,latitude.round(4), "  ",longitude.round(4)].join("--")
  end

  def open_grupes
    self.grupes.where(locked_in_at: nil)
  end

  def locked_grupes
    self.grupes.where.not(locked_in_at: nil)
  end
end

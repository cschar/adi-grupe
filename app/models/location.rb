# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  latitude   :float
#  longitude  :float
#  ltype      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Location < ApplicationRecord

  # 1 location may have many groups using it
  has_many(:grupes)

  def my_tostring
    ["custom address" ,latitude, "  ",longitude].join("--")
  end
end

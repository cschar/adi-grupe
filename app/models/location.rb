class Location < ApplicationRecord

  # 1 location may have many groups using it
  has_many(:grupes)

  def my_tostring
    ["custom address" ,latitude, "  ",longitude].join("--")
  end
end

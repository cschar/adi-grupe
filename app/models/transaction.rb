class Transaction < ApplicationRecord
  geocoded_by :address   #setups up geocoder gem on this model and looks for address method

  #and call geocode using above setting after validation step
  # after_validation(:geocode , if: :address_changed?)

  def address
    [street, city, zip, state].compact.join(", ")
  end

  def address_changed?
    street_changed? || city_changed? || zip_changed? || state_changed?
  end

  def foo
    "heyoheyo"
  end
end
class AddRegionToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column(:locations, :region,    :text)
  end
end

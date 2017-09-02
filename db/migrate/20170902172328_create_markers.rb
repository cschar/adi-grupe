class CreateMarkers < ActiveRecord::Migration[5.1]
  def change
    create_table :markers do |t|

      t.integer :user_id
      t.decimal   :lat,  {:precision=>10, :scale=>6}
      t.decimal   :lng,  {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end

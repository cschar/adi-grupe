class CreateLstats < ActiveRecord::Migration[5.1]
  def change
    create_table :lstats do |t|
      t.integer :location_id
      t.jsonb :data
    end
  end
end

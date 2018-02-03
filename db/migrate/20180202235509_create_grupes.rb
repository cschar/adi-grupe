class CreateGrupes < ActiveRecord::Migration[5.1]
  def change
    create_table :grupes do |t|
      t.string :name
      t.integer :location_id

      t.timestamps
    end
  end
end

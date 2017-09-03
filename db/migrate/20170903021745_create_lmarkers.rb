class CreateLmarkers < ActiveRecord::Migration[5.1]
  def change
    create_table :lmarkers do |t|
      t.decimal :lat
      t.decimal :lng
      t.integer :user_id
      t.string :ltype

      t.timestamps
    end
  end
end

class CreateFiretrees < ActiveRecord::Migration[5.1]
  def change
    create_table :firetrees do |t|
      t.string :name
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end

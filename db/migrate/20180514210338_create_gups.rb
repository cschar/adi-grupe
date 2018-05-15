class CreateGups < ActiveRecord::Migration[5.1]
  def change
    create_table :gups do |t|
      t.references :user, foreign_key: true
      t.references :grupe, foreign_key: true
      t.datetime :confirmed_time

      t.timestamps
    end
  end
end

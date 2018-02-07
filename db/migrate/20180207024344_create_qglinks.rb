class CreateQglinks < ActiveRecord::Migration[5.1]
  def change
    create_table :qglinks do |t|
      t.string :subject
      t.references :quest, foreign_key: true
      t.references :grupe, foreign_key: true

      t.timestamps
    end
  end
end

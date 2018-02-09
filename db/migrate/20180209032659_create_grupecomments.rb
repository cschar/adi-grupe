class CreateGrupecomments < ActiveRecord::Migration[5.1]
  def change
    create_table :grupecomments do |t|
      t.references :grupe, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment
      t.integer :grupecomment_id

      t.timestamps
    end
  end
end

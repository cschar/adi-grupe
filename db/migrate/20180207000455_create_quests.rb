class CreateQuests < ActiveRecord::Migration[5.1]
  def change
    create_table :quests do |t|
      t.string :name
      t.text :body
      t.string :ltype



      t.timestamps
    end
  end
end

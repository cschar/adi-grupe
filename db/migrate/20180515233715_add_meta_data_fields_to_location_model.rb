class AddMetaDataFieldsToLocationModel < ActiveRecord::Migration[5.1]
  def change

    # not needed, can do figure this out with a sql query
    # every day and update 
    add_column(:locations, :total_grupes, :integer, default: 0)
     
     add_column :locations, :recent_quest_id, :integer
  end
end

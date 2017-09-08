class AddUserIndexToLmarkers < ActiveRecord::Migration[5.1]
  def change
    add_index :lmarkers, :user_id
  end
end

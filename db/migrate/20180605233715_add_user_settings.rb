class AddUserSettings < ActiveRecord::Migration[5.1]
  def change
    add_column(:users, :settings,    :text)
    add_column(:users, :preferences, :json)
     

  end
end

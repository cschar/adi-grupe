class AddLockedInAtToGrupeModel < ActiveRecord::Migration[5.1]
  def change
    add_column(:grupes, :locked_in_at,    :datetime)
    add_column(:grupes, :capacity,        :integer,  default: 2)
     

  end
end

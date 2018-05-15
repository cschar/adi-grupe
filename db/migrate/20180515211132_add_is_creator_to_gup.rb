class AddIsCreatorToGup < ActiveRecord::Migration[5.1]
  def change
      add_column(:gups, :is_creator, :boolean, default: false)

      add_column(:grupes, :creator_id, :integer)
  end
end

class AddIsNewToLmarker < ActiveRecord::Migration[5.1]
  def change
    add_column(:lmarkers, :is_new, :boolean, {:default => true})
  end
end

class RemoveMultipleColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :encounters, :enemy_id, :integer
    remove_column :encounters, :item_id, :integer
    remove_column :items, :character_id, :integer
  end
end

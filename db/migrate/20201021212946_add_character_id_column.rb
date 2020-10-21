class AddCharacterIdColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :encounters, :character_id, :integer
  end
end

class CreateEncounters < ActiveRecord::Migration[6.0]
  def change
    create_table :encounters do |t|
      t.integer :enemy_id
      t.integer :item_id
      t.boolean :enemy
      t.boolean :item
      t.string :result
    end 
  end
end

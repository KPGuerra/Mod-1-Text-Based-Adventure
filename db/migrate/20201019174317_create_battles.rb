class CreateBattles < ActiveRecord::Migration[6.0]
  def change
    create_table :battles do |t|
      t.integer :enemy_id
      t.integer :character_id
      t.string :result
    end
  end
end

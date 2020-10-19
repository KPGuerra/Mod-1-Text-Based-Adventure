class CreateEnemies < ActiveRecord::Migration[6.0]
  def change
    create_table :enemies do |t|
      t.string :name
      t.string :role
      t.string :description
      t.integer :hp
      t.integer :level 
    end
  end
end

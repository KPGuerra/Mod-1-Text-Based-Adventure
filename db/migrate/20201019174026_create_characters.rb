class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :role
      t.string :description
      t.integer :hp
      t.integer :level
      t.integer :experience_points
      t.integer :user_id
    end
  end
end

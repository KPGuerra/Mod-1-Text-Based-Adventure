class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description 
      t.string :type
      t.integer :character_id
    end 
  end
end

class AddCurrentWeaponColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :current_weapon, :string
    add_column :characters, :base_hp, :integer
    add_column :characters, :base_attk, :integer
  end
end

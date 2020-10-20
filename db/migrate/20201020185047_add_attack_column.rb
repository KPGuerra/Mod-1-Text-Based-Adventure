class AddAttackColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :enemies, :attack_power, :integer
    add_column :characters, :attack_power, :integer
  end
end

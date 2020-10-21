class AddBossColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :enemies, :boss, :boolean
  end
end

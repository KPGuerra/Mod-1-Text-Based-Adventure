class DropBattles < ActiveRecord::Migration[6.0]
  def change
    drop_table :battles
  end
end

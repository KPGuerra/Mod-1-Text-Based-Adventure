class RemoveRoomCountColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :room_count, :integer
  end
end

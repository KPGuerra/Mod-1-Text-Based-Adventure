class RemoveXpColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :characters, :xp, :integer
  end
end

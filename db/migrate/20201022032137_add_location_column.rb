class AddLocationColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :location, :string
  end
end

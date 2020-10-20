class AddIdColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :encounter_id, :integer
    add_column :enemies, :encounter_id, :integer
  end
end

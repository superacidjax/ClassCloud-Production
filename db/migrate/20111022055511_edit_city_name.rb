class EditCityName < ActiveRecord::Migration
  def up
    remove_column :cities, :name
    remove_column :cities, :state_id
    add_column :cities,:name,:integer
    add_column :cities,:state_id,:integer
  end

  def down
  end
end

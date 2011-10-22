class EditCityStateId < ActiveRecord::Migration
  def up
    remove_column :cities, :name
    add_column :cities,:name,:string
  end

  def down
  end
end

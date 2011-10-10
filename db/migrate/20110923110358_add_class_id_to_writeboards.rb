class AddClassIdToWriteboards < ActiveRecord::Migration
  def change
    add_column :writeboards, :class_room_id, :integer
    add_index :writeboards, :class_room_id
  end
end

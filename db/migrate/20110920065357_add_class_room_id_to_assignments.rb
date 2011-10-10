class AddClassRoomIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :class_room_id, :integer
    add_index :assignments, :class_room_id
  end
end

class AddClassRoomIdFieldToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :class_room_id, :integer
    add_index :notes, :class_room_id
  end
end

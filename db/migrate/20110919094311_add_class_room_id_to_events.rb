class AddClassRoomIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :class_room_id, :integer
    add_index :events, :class_room_id
  end
end

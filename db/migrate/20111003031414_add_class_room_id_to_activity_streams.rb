class AddClassRoomIdToActivityStreams < ActiveRecord::Migration
  def change
    add_column :activity_streams, :class_room_id, :integer
    add_index :activity_streams, :class_room_id
  end
end

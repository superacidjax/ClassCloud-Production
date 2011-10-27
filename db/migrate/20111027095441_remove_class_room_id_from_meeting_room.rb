class RemoveClassRoomIdFromMeetingRoom < ActiveRecord::Migration
  def up
    remove_column :meeting_rooms,:class_room_id
  end

  def down
  end
end

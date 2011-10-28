class RemoveMeetingRoomEventFromMeetingRoom < ActiveRecord::Migration
  def up
    remove_column :meeting_rooms,:is_meeting_room_event
    add_column :events, :is_meeting_room_event,:boolean,:default =>false
  end

  def down
  end
end

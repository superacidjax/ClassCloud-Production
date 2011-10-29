class AddMeetingRoomIdToEvent < ActiveRecord::Migration
  def change
    add_column :meeting_rooms, :is_meeting_room_event,:boolean,:default =>false
  end
end

class AddMeetingRoomToEvent < ActiveRecord::Migration
  def change
    remove_column :events,:is_meeting_room_event
    add_column :events,:meeting_room_id ,:integer
  end
end

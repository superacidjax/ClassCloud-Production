class AddIsUserMeetingRoomToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_user_meeting_room, :boolean, :default =>false
  end
end

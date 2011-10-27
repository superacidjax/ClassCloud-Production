class CreateUserMeetingRooms < ActiveRecord::Migration
  def change
    create_table :user_meeting_rooms do |t|
      t.integer :user_id
      t.integer :meeting_room_id
      t.boolean :moderator , :default =>false
      t.timestamps
    end
  end
end

class CreateMeetingRooms < ActiveRecord::Migration
  def change
    create_table :meeting_rooms do |t|
      t.string :title
      t.string :meeting_type
      t.integer :user_id
      t.integer :class_room_id
      t.timestamps
    end
  end
end

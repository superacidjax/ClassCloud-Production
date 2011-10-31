class RemoveMeetingTypeFromMeetingRoom < ActiveRecord::Migration
  def up
    remove_column :meeting_rooms, :meeting_type
  end

  def down
  end
end

class AddDescriptionToMeetingRoom < ActiveRecord::Migration
  def change
    add_column :meeting_rooms, :description , :string
  end
end

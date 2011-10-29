class UserMeetingRoom < ActiveRecord::Base
  belongs_to :meeting_room
  belongs_to :user
end

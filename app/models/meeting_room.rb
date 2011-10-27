class MeetingRoom < ActiveRecord::Base
  has_one :user

  after_create :create_meeting_room_user



  def self.create_meeting_room_user(user_meeting,role)
    users = []
    users << params[:user_meeting]
    users.each do |username|
    user = User.where("username = ?", username).first
    meeting_room_user = MeetingRoomUser.create(user_id: user.id,meeting_room_id: self.id, meeting_type: self.meeting_type )
    end

  end
  MEETING_TYPE = [
    "Files",
    "Meeting Notes",
    "Discussions",
    "Announcements",
    "Calendar",
    "People"
  ]

  
end

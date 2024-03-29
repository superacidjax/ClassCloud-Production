class MeetingRoom < ActiveRecord::Base
  belongs_to :user

  has_many :user_meeting_rooms,:dependent =>:destroy

  acts_as_commentable
  
  def create_meeting_room_user(user_meeting)
    Event.create(:name => self.title, :start_at => Date.today, :end_at =>Date.today, :user_id =>self.user_id,:meeting_room_id =>self.id)
    users = user_meeting.split(',')
    user_meeting.each do |email|
      user = User.where("email = ?", email).first
      unless user.nil?
        MeetingRoomMailer.welcome_email(user,self.id).deliver
      end
      UserMeetingRoom.create(:user_id=> user.id,:meeting_room_id=> self.id)
      Event.create(:name => self.title, :start_at => Time.now.to_date, :end_at =>Time.now.to_date, :user_id =>user.id,:meeting_room_id =>self.id)
    end
  end
  
  
end

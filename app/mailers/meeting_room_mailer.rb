  class MeetingRoomMailer < ActionMailer::Base
  default from: "admin@classcloud.com"

  def welcome_email(user,meeting_room_id)
    @user = user
    @url  = "http://localhost:3000/meeting_rooms/#{meeting_room_id}"
    
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
end

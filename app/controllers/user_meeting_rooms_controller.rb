class UserMeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user_meeting_rooms = UserMeetingRoom.all
  end

 
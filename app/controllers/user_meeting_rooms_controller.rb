class UserMeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @user_meeting_rooms = UserMeetingRoom.all
  end

  def show
    @user_meeting_room = UserMeetingRoom.find(params[:id])
  end

  def new
    @user_meeting_room = UserMeetingRoom.new
  end

  def edit
    @user_meeting_room = UserMeetingRoom.find(params[:id])
  end

  def create
    @user_meeting_room = UserMeetingRoom.new(params[:user_meeting_room])

    if  @user_meeting_room.save
      redirect_to @user_meeting_room, notice: 'User meeting room was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user_meeting_room = UserMeetingRoom.find(params[:id])

    if @user_meeting_room.update_attributes(params[:user_meeting_room])
      redirect_to @user_meeting_room, notice: 'User meeting room was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user_meeting_room = UserMeetingRoom.find(params[:id])
    @user_meeting_room.destroy

    redirect_to user_meeting_rooms_url
  end
end

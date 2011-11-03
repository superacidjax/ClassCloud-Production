class UserMeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_meeting_room , :only => [:edit,:show, :update, :destroy]
  
  def index
    @user_meeting_rooms = UserMeetingRoom.all
  end

  def show    
  end

  def new
    @user_meeting_room = UserMeetingRoom.new
  end

  def edit    
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
    if @user_meeting_room.update_attributes(params[:user_meeting_room])
      redirect_to @user_meeting_room, notice: 'User meeting room was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy    
    @user_meeting_room.destroy

    redirect_to user_meeting_rooms_url
  end

  private

  def user_meeting_room
    @user_meeting_room = UserMeetingRoom.find(params[:id])
  end
end

class MeetingRoomsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @meeting_rooms = MeetingRoom.all
  end

  def show
    @meeting_room = MeetingRoom.find(params[:id])
  end

  def new
    @meeting_room = MeetingRoom.new
  end

  def edit
    @meeting_room = MeetingRoom.find(params[:id])
  end

  def create
    @meeting_room = MeetingRoom.new(params[:meeting_room])
    MeetingRoom.create_meeting_room_user(params[:user_meeting],params[:user][:role])
    if @meeting_room.save

      redirect_to @meeting_room, notice: 'Meeting room was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @meeting_room = MeetingRoom.find(params[:id])

    if @meeting_room.update_attributes(params[:meeting_room])
      redirect_to @meeting_room, notice: 'Meeting room was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_room.destroy

    redirect_to meeting_rooms_url
  end

  def user
    @user = User.search_by_name(params[:q])
    require 'pp'

    pp @user
    if @user.blank?
      render :json => []
    else
      render :json =>@user.json_form
    end
    
  end

end

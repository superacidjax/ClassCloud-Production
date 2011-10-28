class MeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  layout 'layouts/meeting_room'
  
  def index
    @meeting_rooms = MeetingRoom.all
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @class = current_user.class_rooms
    @event_strips = current_user.events.where("date(start_at) BETWEEN date(now()) and date(start_at) +14").event_strips_for_month(@shown_month)

    if current_user.is_student?
      current_user.class_room_students.each do|class_room_student|
        @event_strips += Event.where("user_id =? and date(start_at) BETWEEN date(now()) and date(start_at) +14",class_room_student.class_room.user_id).event_strips_for_month(@shown_month)
      end
    end
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

    if @meeting_room.save
      @meeting_room.create_meeting_room_user(params[:user_meeting])
      redirect_to meeting_rooms_path, notice: 'Meeting room was successfully created.'
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

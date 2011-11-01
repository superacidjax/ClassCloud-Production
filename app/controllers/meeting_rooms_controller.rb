class MeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  layout 'layouts/meeting_room'
  
  def index
    
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
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
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def show
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @meeting_room = MeetingRoom.find(params[:id])
    @user_meeting_rooms = @meeting_room.user_meeting_rooms
    @user_meeting_room = @meeting_room.user_meeting_rooms.where("user_id = ? AND moderator = ?",current_user.id, true)
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def new
    @meeting_room = MeetingRoom.new
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def edit
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def create
    require "pp"
    @meeting_room = MeetingRoom.new(params[:meeting_room])

    if @meeting_room.save
      user_meeting = []
      counter = params[:user_meeting].split(',').count
      for i in(1..counter)
        if (i%2).eql?(1)
          user_meeting << params[:user_meeting].split(',')[i]
        end
      end
      @meeting_room.create_meeting_room_user(user_meeting)
      
      unless params[:user].nil?
        counter = params[:user][:email].count
        tmp = User.generate_random_string
        for i in(0..counter)
          user = User.new
          user.email = params[:user][:email][i]
          user.first_name = params[:user][:first_name][i]
          user.last_name = params[:user][:last_name][i]
          user.password = tmp
          user.password_confirmation = tmp
          if params[:user][:role].nil?
            user.add_role "other"
          else
            user.add_role params[:user][:role][i]
          end
          user.is_user_meeting_room = true
          if user.save
            @meeting_room.user_meeting_rooms.create(:user_id =>user.id)

          end
        end
      end
      redirect_to moderator_meeting_room_url(@meeting_room), notice: 'Meeting room was successfully created.'
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

    if @user.blank?
      render :json => []
    else
      render :json =>@user.json_form
    end
    
  end

  def comment_new
    @meeting_room = MeetingRoom.find(params[:id])
    @user_meeting_room = @meeting_room.user_meeting_rooms.where("user_id = ? AND moderator = ?",current_user.id, true)
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def comment_create
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_room.comments.create(:comment => params[:comment], :user_id => current_user.id)
    
    redirect_to meeting_room_url(params[:id])
  end

  def comment_destroy
    @meeting_room = MeetingRoom.find(params[:id])
    comment = @meeting_room.comments.find(params[:comment_id])
    comment.destroy if comment

    redirect_to meeting_room_url(params[:id])
  end

  def comment_edit
    @meeting_room = MeetingRoom.find(params[:id])
    @comment = @meeting_room.comments.find(params[:comment_id])
    @user_meeting_room = @meeting_room.user_meeting_rooms.where("user_id = ? AND moderator =?",current_user.id, true)
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def comment_update
    @meeting_room = MeetingRoom.find(params[:id])
    @comment = @meeting_room.comments.find(params[:comment_id])

    if @comment.update_attribute("comment", params[:comment])
      redirect_to meeting_room_url(params[:id])
    else
      render :action => "comment_edit"
    end
  end

  def moderator
    @meeting_room = MeetingRoom.find(params[:id])
    @meeting_rooms = current_user.meeting_rooms
    @user_meeting_rooms = current_user.user_meeting_rooms
    @students = []
    current_user.class_rooms.each do |class_room|
      @students << class_room.students
    end
    @students.flatten!
  end

  def add_moderator
    user_meeting_room = UserMeetingRoom.find(params[:id])
    user_meeting_room.update_attribute("moderator",params[:user][:moderator])
    user_meeting_room.save!
    
    redirect_to moderator_meeting_room_url(user_meeting_room.meeting_room.id)
  end
end

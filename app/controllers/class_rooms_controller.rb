class ClassRoomsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @class_room = ClassRoom.new
    @students = []

    current_user.class_rooms.each do |cr|
      cr.students.each do |student|
        @students << student
      end
    end
  end

  def index    
    render :layout => false
  end

  def create
    if params[:without_student].eql?("true")
      @class_room = ClassRoom.new(:name => params[:class_room][:name], :user_id => current_user.id)
      
      if @class_room.save
        redirect_to root_url
      else        
        @students = User.all(:conditions => "roles LIKE '%student%'")
        render :action => "new"
      end
    else
      class_room = ClassRoom.new(:name => params[:class_room][:name], :user_id => current_user.id)

      if class_room.save!
        if !params[:user][:first_name].blank? or !params[:user][:last_name].blank? or !params[:user][:email].blank?
          student = User.new(params[:user])
          student.is_not_teacher = true
          student.password = "123456"
          student.password_confirmation = "123456"
          student.user_type = "student"

          if student.save
            student.add_role "student"
            student.save
            ClassRoomStudent.create(:user_id => student.id, :class_room_id => class_room.id)
            redirect_to root_url
          else            
            @error_messages = student.errors.full_messages
            class_room.destroy
            render :template => "dashboard/index", :layout => false
          end
        else
          redirect_to root_url
        end
      else
        @error_messages = class_room.errors.full_messages
        render :template => "dashboard/index"
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @class = if current_user.is_teacher?
      current_user.class_rooms.find(params[:id])
    elsif current_user.is_student?
      my_class_room = ClassRoomStudent.where(class_room_id: params[:id]).first
      my_class_room.class_room unless my_class_room.blank?
    elsif current_user.is_observer?
      if !params[:student_id].blank?
        @student = User.find params[:student_id]
        student_class_room = ClassRoomStudent.where(class_room_id: params[:class_room_id]).first
        student_class_room.class_room unless student_class_room.blank?
      elsif !params[:teacher_id].blank?
        @teacher = User.find params[:teacher_id]
        ClassRoom.find(params[:class_room_id])
      end
    end
    @students = @class.students unless current_user.is_observer?

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = if @class
      @class.events.event_strips_for_month(@shown_month)
    else
      Event.event_strips_for_month(@shown_month)
    end
    
    @activity_streams = @class.activity_streams.order("created_at ASC")
  end

end

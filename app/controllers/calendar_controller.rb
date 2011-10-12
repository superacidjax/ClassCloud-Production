class CalendarController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@event, :name, :comment_create, :event

  before_filter :teacher_required!, :except => [:index, :show, :comment_create, :download,:comment_edit,:comment_update,:comment_destroy]
  before_filter :teacher_or_student_required!, :only => [:comment_create,:comment_edit,:comment_update,:comment_destroy]
  before_filter :get_my_students_and_class, :only => [:new, :remove_file, :comment_edit]
  
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)
    @event_strips = Event.event_strips_for_month(@shown_month)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(params[:event])
    @event.class_room_id = params[:class_room_id]
    if @event.save
      redirect_to class_room_url(params[:class_room_id])
    else
      @class = current_user.class_rooms.find(params[:class_room_id])
      @students = @class.students
      render :action => "new"
    end
  end

  def edit
    @event = Event.find(params[:id])
    @class = @event.class_room
    @students = @class.students
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      redirect_to class_room_url(params[:class_room_id])
    else
      @class = @event.class_room
      @students = @class.students
      render :action => "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to class_room_url(params[:class_room_id])
  end

  def show
    if current_user.is_observer? and params[:student_id]
      @student = User.find params[:student_id]
    elsif current_user.is_observer? and params[:teacher_id]
      @teacher = User.find params[:teacher_id]
    end

    @event = Event.find(params[:id])
    @class = @event.class_room
    @students = @class.students
  end

  def comment_create
    @event = Event.find(params[:id])
    @event.comments.create(:comment => params[:comment], :user_id => current_user.id)
    @class = @event.class_room
    @students = @class.students
    render :action => "show"
  end

  def comment_destroy
    @event = Event.find(params[:id])
    @class = @event.class_room
    comment = @event.comments.find(params[:comment_id])
    comment.destroy if comment
    render :action => "show"
  end

  def comment_edit
    @event = Event.find(params[:id])
    @comment = @event.comments.find(params[:comment_id])
    @class = @event.class_room
  end

  def comment_update
    @event = Event.find(params[:id])
    @comment = @event.comments.find(params[:comment_id])
    @class = @event.class_room
    if @comment.update_attribute("comment", params[:comment])
      render :action => "show"
    else
      render :action => "comment_edit"
    end
  end

  def download
    file = Event.find(params[:id])
    send_file file.file.path, :type => file.file_content_type
  end

  def remove_file
    file = Event.find(params[:id])
    if file.update_attributes(:file_updated_at =>'')
      redirect_to class_room_url(@class.id)
    else
      redirect_to class_room_url(@class.id)
    end
  end

  private

  def get_my_students_and_class
    @class = if current_user.is_teacher?
      current_user.class_rooms.find(params[:class_room_id])
    elsif current_user.is_student?
      my_class_room = current_user.class_room_students.where(class_room_id: params[:class_room_id]).first
      my_class_room.class_room
    elsif current_user.is_observer?
      if params[:student_id]
        @student = User.find params[:student_id]
        student_class_room = @student.class_room_students.where(class_room_id: params[:class_room_id]).first
        student_class_room.class_room if student_class_room
      elsif params[:teacher_id]
        @teacher = User.find params[:teacher_id]
        ClassRoom.find params[:class_room_id]
      end
    end
    @students = @class.students
  end
  
end

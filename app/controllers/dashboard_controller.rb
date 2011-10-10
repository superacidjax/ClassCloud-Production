class DashboardController < ApplicationController
  skip_before_filter :set_timezone
  before_filter :authenticate_user!
  
  before_filter :admin?
  def index
    
    @class_rooms = ClassRoom.all
    unless current_user.is_observer?
      if current_user.class_rooms.blank?
        @my_class_rooms = if current_user.is_student?
          my_class_rooms = []
          current_user.class_room_students.each do |class_room_student|
            my_class_rooms << class_room_student.class_room
          end
          my_class_rooms
        end
        @error_messages = []
      else
        @my_class_rooms = current_user.class_rooms
        @students = []
        @my_class_rooms.each do |cr|
          cr.class_room_students.each do |cr_student|
            @students << cr_student.student unless @students.include?(cr_student.student)
          end
        end
      end
      @student = User.find(params[:id]) if current_user.is_teacher? and params[:id]
    else
      if params[:id].blank? and params[:teacher_id].blank?
        @students = []
        @my_class_rooms = []
        current_user.class_room_observers.each do |class_room_observer|
          class_room_student = ClassRoomStudent.where(class_room_id: class_room_observer.class_room_id).first
          @my_class_rooms << class_room_observer.class_room
          @students << class_room_student.student if class_room_student and !@students.include?(class_room_student.student)
        end
        @teacher = current_user.class_room_observers.first.class_room.user unless current_user.class_room_observers.blank?
      elsif params[:id]
        @student = User.find params[:id]
        @my_class_rooms = []
        @student.class_room_students.each do |class_room_student|
          @my_class_rooms << class_room_student.class_room
        end
        @error_messages = []
      elsif params[:teacher_id]
        @teacher = User.find params[:teacher_id]
        @my_class_rooms = @teacher.class_rooms
        @students = []
        @my_class_rooms.each do |cr|
          cr.class_room_students.each do |cr_student|
            @students << cr_student.student unless @students.include?(cr_student.student)
          end
        end
        @student = User.find(params[:student_id]) if params[:student_id]
        @error_messages = []
      end
    end
    @activity_streams = ActivityStream.where(["class_room_id IN (?)", @my_class_rooms.map(&:id)]).order("created_at ASC") if @my_class_rooms
  end
end

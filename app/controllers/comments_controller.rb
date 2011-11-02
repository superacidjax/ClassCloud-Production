class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_my_students_and_class
  
  def index
    commentable_type = params[:commentable_type]
    post = Comment.find(params[:comment_id])
    current_user.vote_for(post)
    controller = params[:commentable_type]
    
    if controller.eql?('assignments')
#      redirect_to comment_new_class_room_assignment_url(@class.id,params[:id])
      redirect_to "/class_rooms/#{@class.id}/assignments/#{params[:id]}/comment_new#comment#{params[:comment_id]}"
    elsif controller.eql?('notes')
      redirect_to  "/class_rooms/#{@class.id}/notes/#{params[:id]}/comment_new#comment#{params[:comment_id]}"
    elsif controller.eql?('discussions')
      redirect_to  "/class_rooms/#{@class.id}/discussions/#{params[:id]}/comment_new#comment#{params[:comment_id]}"
    elsif controller.eql?('calendar')
      redirect_to  class_room_event_url(@class.id,params[:id])
    elsif controller.eql?('writeboards')
      redirect_to  class_room_writeboard_url(@class.id,params[:id])
    end
  end

  def reply
    @reply = Reply.create(params[:reply])
    @reply.save
    if params[:comment_controller].eql?('calendar')
      redirect_to(event_url(params[:id]),notice: 'Comment has been replied')
    else
      redirect_to(("/class_rooms/#{@class.id}/#{params[:comment_controller]}/#{params[:id]}/comment_new"),notice: 'Comment has been replied')
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
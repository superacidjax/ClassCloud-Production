class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_my_students_and_class
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def index
    commentable_type = params[:commentable_type]
    #    debugger
    post = Comment.find(params[:comment_id])
    current_user.vote_for(post)
    respond_to do |format|
      format.html { redirect_to class_room_url(@class.id) }
      format.json { head :ok }
    end

<<<<<<< HEAD
=======
  
  def index
    commentable_type = params[:commentable_type]
    post = Comment.find(params[:comment_id])
    current_user.vote_for(post)
    redirect_to class_room_url(@class.id)
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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

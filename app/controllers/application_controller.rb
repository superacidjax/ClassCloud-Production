class ApplicationController < ActionController::Base
  include LogActivityStreams
  protect_from_forgery

  before_filter :provide_system_the_username_and_password
  before_filter :get_my_students_and_class
  before_filter :admin?
  before_filter :set_timezone
  
  def teacher_required!
    unless current_user && current_user.is_teacher?
      flash[:error] = "Sorry, you don't have access to that."
      redirect_to root_url and return false
    end
  end

  def teacher_or_student_required!
    if !current_user or current_user.is_observer?
      flash[:error] = "Sorry, you don't have access to that."
      redirect_to root_url and return false
    end
  end

  def student_required!
    if !current_user or !current_user.is_student?
      flash[:error] = "Sorry, you don't have access to that."
      redirect_to root_url and return false
    end
  end
 
  def provide_system_the_username_and_password
    if params[:controller].eql?("devise/confirmations") and params[:action].eql?("show")
      
      unactivated_user = User.find_by_confirmation_token(params[:confirmation_token])
      redirect_to pick_username_and_password_url(:confirmation_token => params[:confirmation_token]) if unactivated_user and unactivated_user.username.nil? and params[:user_save_username_and_password].blank?
    end
  end

  def not_observer!
    if !current_user or current_user.is_observer?
      flash[:error] = "Sorry, you don't have access to that."
      redirect_to root_url and return false
    else
      true
    end
  end

  def admin?
    if params[:controller].eql?("dashboard")and current_user.admin?
      redirect_to admin_admins_path

    end
  end

  def set_timezone
    Time.zone = current_user.time_zone if current_user
  end
  
  private
  
  def get_my_students_and_class
    if params[:controller].eql?("devise/registrations") and (params[:action].eql?("edit") or params[:action].eql?("update"))
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

end

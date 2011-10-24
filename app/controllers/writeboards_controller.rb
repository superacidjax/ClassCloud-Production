class WriteboardsController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@writeboard, :title, :comment_create, :writeboard

  log_activity_streams :current_user, :full_name, :completed,
    :@assignment, :title, :create, :assignment

  before_filter :authenticate_user!

  def index
    @writeboards = if current_user.is_teacher?
      @class.writeboards
    else
      unless current_user.is_observer?
        @class.writeboards.where(user_id: current_user.id)
      else
        if @student
          @class.writeboards.where(user_id: @student.id)
        elsif @teacher
          @class.writeboards
        end
      end
    end
    if @student
      @public_class_writeboards = @class.writeboards.where(["user_id <> ? AND is_public = TRUE", @student.id]) if not (current_user.is_teacher? or current_user.is_observer?)
    else
      @public_class_writeboards = @class.writeboards.where(["user_id <> ? AND is_public = TRUE", current_user.id]) if not (current_user.is_teacher? or current_user.is_observer?)
    end
  end

  def show
    @writeboard = Writeboard.find(params[:id])
  end

  def new
    @writeboard = current_user.writeboards.new
    assignment_student = current_user.assignment_students.where(assignment_id: params[:assignment_id]).first
    @assignment = assignment_student.blank? ? Assignment.find(params[:assignment_id]) : assignment_student.assignment
  end

  def create
    @writeboard = current_user.writeboards.new(params[:writeboard])
    @writeboard.assignment_id = params[:assignment_id]
    @writeboard.class_room_id = params[:class_room_id]
    assignment = Assignment.find(params[:assignment_id])
    @writeboard.is_public = assignment.is_public
    
    if @writeboard.save
      @assignment = @writeboard.assignment
      redirect_to (class_room_assignments_url(@class.id)), notice: 'Writeboard was successfully created.'
    else
      assignment_student = current_user.assignment_students.where(assignment_id: params[:assignment_id]).first
      @assignment = assignment_student.blank? ? nil : assignment_student.assignment
      render action: "new"
    end
  end

  def edit
    @writeboard = Writeboard.find(params[:id])
    @assignment = @writeboard.assignment
  end

  def update
    if !params['version'].eql?('1') and !current_user.is_teacher?
      @writeboard = current_user.writeboards.new(params[:writeboard])
      @writeboard.assignment_id = params[:assignment_id]
      @writeboard.class_room_id = params[:class_room_id]
      assignment = Assignment.find(params[:assignment_id])
      @writeboard.is_public = assignment.is_public
      writeboard = Writeboard.find(params[:id])
      @writeboard.version = writeboard.version.to_i+1
      if @writeboard.save
        @assignment = @writeboard.assignment
        if current_user.is_student?
          redirect_to (class_room_assignments_url(@class.id)), notice: 'Writeboard was successfully updated.'
        else
          redirect_to (class_room_writeboards_url(@class.id)), notice: 'Writeboard was successfully updated.'
        end
      else
        assignment_student = current_user.assignment_students.where(assignment_id: params[:assignment_id]).first
        @assignment = assignment_student.blank? ? nil : assignment_student.assignment
        render action: "new"
      end

    else
      @writeboard = Writeboard.find(params[:id])
      if current_user.is_teacher?
        params[:writeboard][:edited_by_teacher] = true
        if @writeboard.update_attributes(params[:writeboard])
          redirect_to (class_room_writeboards_url(@class.id)), notice: 'Writeboard was successfully updated.'
         
        else
          render action: "edit"
        end
      else
        if @writeboard.update_attributes(params[:writeboard],:version =>'2')
          if current_user.is_student?
            redirect_to (class_room_assignments_url(@class.id)), notice: 'Writeboard was successfully updated.'
          else
            redirect_to (class_room_writeboards_url(@class.id)), notice: 'Writeboard was successfully updated.'
          end
        else
          render action: "edit"
        end
      end
    end
  end
  
  def destroy
    @writeboard = Writeboard.find(params[:id])
    @writeboard.destroy
    if current_user.is_student?
      redirect_to (class_room_assignments_url(@class.id))
    else
      redirect_to (class_room_writeboards_url(@class.id))
    end
  end

  def comment_create
    @writeboard = Writeboard.find(params[:id])
    @writeboard.comments.create(:comment => params[:comment], :user_id => current_user.id)
    render :action => "show"
  end

  def comment_edit
    @writeboard = Writeboard.find(params[:id])
    @comment =  @writeboard.comments.find(params[:comment_id])
  end

  def comment_update
    @writeboard = Writeboard.find(params[:id])
    @comment =  @writeboard.comments.find(params[:comment_id])

    if @comment.update_attribute("comment", params[:comment])
      render :action => "show"
    else
      render :action => "comment_edit"
    end
  end

  def comment_destroy
    @writeboard = Writeboard.find(params[:id])
    comment =  @writeboard.comments.find(params[:comment_id])
    comment.destroy if comment
    render :action => "show"
  end


  def vote_up
    post = Writeboard.find(params[:id])
    current_user.vote_for(post)
    
    redirect_to class_room_writeboards_url(@class.id) 
  end

  private

  def get_my_students_and_class
    @class = if user_teacher?
      current_user.class_rooms.find(params[:class_room_id])
    elsif user_student?
      my_class_room = current_user.class_room_students.where(class_room_id: params[:class_room_id]).first
      my_class_room.class_room if my_class_room
    elsif user_observer?
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

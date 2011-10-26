class AssignmentsController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@assignment, :title, :comment_create, :assignment

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class, :except => :show
  
  def index
    @assignments = @class.assignments
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    @categories = AssignmentCategory.where("class_room_id =?",@class.id)
    @assignment = Assignment.new
  end

  def edit
    @categories = AssignmentCategory.where("class_room_id =?",@class.id)
    @assignment = Assignment.find(params[:id])
  end

  def create
    @assignment = Assignment.new(params[:assignment])
    if params[:assignment]["due_date(1i)"].nil? or params[:assignment]["due_date(2i)"].nil? or params[:assignment]["due_date(3i)"].nil?
      @assignment.due_date = Time.now.to_date.strftime("%Y-%m-%d")
    else
      @assignment.due_date = "#{params[:assignment]["due_date(1i)"]}-#{params[:assignment]["due_date(2i)"]}-#{params[:assignment]["due_date(2i)"]}"
    end
    @assignment.user_id = current_user.id
    @assignment.class_room_id = params[:class_room_id]

    if @assignment.valid?
      if params[:assignment][:group_allowed].eql?("0")
        @assignment.is_public = false
        @assignment.save
      else
        @assignment.is_public = true
        @assignment.save
      end
      
      students = ClassRoomStudent.where(["class_room_id =?",@class.id])
      students.each do |student|
        AssignmentStudent.create(:assignment_id => @assignment.id, :user_id => student.user_id)
      end

      Event.create(:name => @assignment.title, :start_at => @assignment.due_date, :end_at => @assignment.due_date, :user_id => current_user.id, :class_room_id => @class.id, :assignment_id => @assignment.id) unless @assignment.due_date.blank?
         
      redirect_to comment_new_class_room_assignment_url(@class.id, @assignment.id), notice: 'Assignment was successfully created.'
    else
      @assignment_errors = @assignment.errors.full_messages
      @assignment_errors << "Please select group or student that will assign this assignment!" if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
      @categories = AssignmentCategory.all
      render action: "new"
    end
  end

  def update
    @assignment = Assignment.find(params[:id])
    @assignment.due_date = if params[:assignment]["due_date(1i)"].blank? and params[:assignment]["due_date(2i)"].blank? and params[:assignment]["due_date(3i)"].blank?
      nil
    else
      Date.parse("#{params[:assignment]["due_date(1i)"]}-#{params[:assignment]["due_date(2i)"]}-#{params[:assignment]["due_date(3i)"]}") rescue @assignment.due_date
    end
    @assignment.attributes = @assignment.attributes.merge({:title => params[:assignment][:title],
        :description => params[:assignment][:description], :assignment_category_id => params[:assignment][:assignment_category_id],
        :group_allowed => params[:assignment][:group_allowed],:file =>params[:assignment][:file]})

    if @assignment.valid?
      if params[:assignment][:group_allowed].eql?("0") 
        @assignment.is_public = false
        @assignment.save
      else
        @assignment.is_public = true
        @assignment.save

        unless params[:my_student].blank?
          params[:my_student].each do |key, value|
            AssignmentStudent.create(:assignment_id => @assignment.id, :user_id => params[:my_student][key.to_s]) if @assignment.assignment_students.blank? or !@assignment.assignment_students.map(&:user_id).include?(params[:my_student][key.to_s])
          end
        else
          @assignment.assignment_students.destroy_all if params[:assignment][:group_allowed].eql?("1")
        end

        event = Event.find_by_assignment_id(@assignment.id)
        if event.blank?
          Event.create(:name => @assignment.title, :start_at => @assignment.due_date, :end_at => @assignment.due_date, :user_id => current_user.id, :class_room_id => @class.id, :assignment_id => @assignment.id) unless @assignment.due_date.blank?
        else
          unless @assignment.due_date.blank?
            event.name = @assignment.title
            event.start_at = @assignment.due_date
            event.end_at = @assignment.due_date
            event.save
          else
            event.destroy
          end
        end

      end
      redirect_to comment_new_class_room_assignment_url(@class.id, @assignment), notice: 'Assignment was successfully updated.'
    else
      @assignment_errors = @assignment.errors.full_messages
      @assignment_errors << "Please select group or student that will assign this assignment!" if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
      @categories = AssignmentCategory.all
      render action: "edit"
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    redirect_to class_room_assignments_url(@class.id)
  end

  def comment_new
    @assignment = Assignment.find(params[:id])
  end

  def comment_create
    @assignment = Assignment.find(params[:id])
    @assignment.comments.create(:comment => params[:comment], :user_id => current_user.id)
    @assignment.reload
    
    redirect_to comment_new_class_room_assignment_path(params[:class_room_id],params[:id])
  end

  def comment_destroy
    @assignment = Assignment.find(params[:id])
    comment = @assignment.comments.find(params[:comment_id])
    comment.destroy if comment
    
    redirect_to comment_new_class_room_assignment_path(params[:class_room_id],params[:id])
  end

  def comment_edit
    @assignment = Assignment.find(params[:id])
    @comment = @assignment.comments.find(params[:comment_id])
  end

  def comment_update
    @assignment = Assignment.find(params[:id])
    @comment = @assignment.comments.find(params[:comment_id])

    if @comment.update_attribute("comment", params[:comment])
      redirect_to comment_new_class_room_assignment_path(params[:class_room_id],params[:id])
    else
      render :action => "comment_edit"
    end
  end

  def download
    file = Assignment.find(params[:id])
    send_file file.file.path, :type => file.file_content_type
  end

  def remove_file
    file = Assignment.find(params[:id])
    if file.update_attributes(:file_updated_at =>'')
      redirect_to class_room_assignments_url(@class.id)
    else
      render :action => "comment_edit"
    end
  end

  def assignment_category
    @assignment_categories = AssignmentCategory.where("class_room_id =?",@class.id)
  end

  def new_assignment_category
    @assignment_category = AssignmentCategory.new

  end

  def create_assignment_category
    @assignment_category = AssignmentCategory.new(params[:assignment_category])
    @assignment_category.class_room_id = @class.id
    if @assignment_category.save
      redirect_to assignment_category_class_room_assignments_url(@class.id), notice: 'Note was successfully created.'
    else
      render action: "new"
    end
  end

  def delete_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])
    @assignment_category.destroy

    redirect_to(assignment_category_class_room_assignments_url(@class.id))
  end

  def update_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])

    if @assignment_category.update_attributes(params[:assignment_category])
      redirect_to assignment_category_class_room_assignments_url(@class.id), notice: 'Assignment Category was successfully updated.'
    else
      render action: "edit_assignment_category"
    end
  end

  def edit_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])
  end

  def vote_up
    post = Assignment.find(params[:id])
    current_user.vote_for(post)
    
    redirect_to class_room_assignments_url(@class.id)
  end

  private

  def get_my_students_and_class
    @class = if current_user.is_teacher?
      current_user.class_rooms.find(params[:class_room_id])
    elsif current_user.is_student?
      my_class_room = current_user.class_room_students.where(class_room_id: params[:class_room_id]).first
      my_class_room.class_room if my_class_room
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
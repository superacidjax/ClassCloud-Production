class AssignmentsController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@assignment, :title, :comment_create, :assignment

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class, :except => :show
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = @class.assignments

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @categories = AssignmentCategory.all
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
<<<<<<< HEAD
=======
  
  def index
    @assignments = @class.assignments
  end

  def show
    @assignment = Assignment.find(params[:id])
  end

  def new
    @categories = AssignmentCategory.all
    @assignment = Assignment.new
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def edit
    @categories = AssignmentCategory.all
    @assignment = Assignment.find(params[:id])
  end

<<<<<<< HEAD
<<<<<<< HEAD
  # POST /assignments
  # POST /assignments.json
=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # POST /assignments
  # POST /assignments.json
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def create
    @assignment = Assignment.new(params[:assignment])
    @assignment.user_id = current_user.id
    @assignment.class_room_id = params[:class_room_id]

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
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
         
        format.html { redirect_to comment_new_class_room_assignment_url(@class.id, @assignment.id), notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
        
         
      else
        @assignment_errors = @assignment.errors.full_messages
        @assignment_errors << "Please select group or student that will assign this assignment!" if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
        @categories = AssignmentCategory.all
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.json
<<<<<<< HEAD
=======
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

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      if @assignment.valid?
        if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
          @assignment_errors = []
          @assignment_errors << "Please select group or student that will assign this assignment!"
          @categories = AssignmentCategory.all
          format.html { render action: "edit" }
          format.json { render json: @assignment.errors, status: :unprocessable_entity }
        else
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

          format.html { redirect_to comment_new_class_room_assignment_url(@class.id, @assignment), notice: 'Assignment was successfully updated.' }
          format.json { head :ok }
        end
      else
        @assignment_errors = @assignment.errors.full_messages
        @assignment_errors << "Please select group or student that will assign this assignment!" if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
        @categories = AssignmentCategory.all
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
<<<<<<< HEAD
=======
    if @assignment.valid?
      if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
        @assignment_errors = []
        @assignment_errors << "Please select group or student that will assign this assignment!"
        @categories = AssignmentCategory.all
        render action: "edit"
      else
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

        redirect_to comment_new_class_room_assignment_url(@class.id, @assignment), notice: 'Assignment was successfully updated.'
      end
    else
      @assignment_errors = @assignment.errors.full_messages
      @assignment_errors << "Please select group or student that will assign this assignment!" if params[:assignment][:group_allowed].eql?("0") and params[:my_student].blank?
      @categories = AssignmentCategory.all
      render action: "edit"
    end
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      format.html { redirect_to class_room_assignments_url(@class.id) }
      format.json { head :ok }
    end
<<<<<<< HEAD
=======
    redirect_to class_room_assignments_url(@class.id)
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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
    @assignment_categories = AssignmentCategory.all
  end

  def new_assignment_category
    @assignment_category = AssignmentCategory.new

  end

  def create_assignment_category
    @assignment_category = AssignmentCategory.new(params[:assignment_category])

    if @assignment_category.save
      redirect_to assignment_category_class_room_assignments_url(@class.id), notice: 'Note was successfully created.'
    else
      render action: "new"
    end
  end

  def delete_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])
    @assignment_category.destroy

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      format.html { redirect_to(assignment_category_class_room_assignments_url(@class.id)) }
      format.json { head :ok }
    end
<<<<<<< HEAD
=======
    redirect_to(assignment_category_class_room_assignments_url(@class.id))
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  end

  def update_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      if @assignment_category.update_attributes(params[:assignment_category])
        format.html { redirect_to assignment_category_class_room_assignments_url(@class.id), notice: 'Assignment Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit_assignment_category" }
        format.json { render json: @assignment_category.errors, status: :unprocessable_entity }
      end
    end
<<<<<<< HEAD
=======
      if @assignment_category.update_attributes(params[:assignment_category])
        redirect_to assignment_category_class_room_assignments_url(@class.id), notice: 'Assignment Category was successfully updated.'
      else
        render action: "edit_assignment_category"
      end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  end

  def edit_assignment_category
    @assignment_category = AssignmentCategory.find(params[:id])
  end

  def vote_up
    post = Assignment.find(params[:id])
    current_user.vote_for(post)
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      format.html { redirect_to class_room_assignments_url(@class.id) }
      format.json { head :ok }
    end
  end

  
<<<<<<< HEAD
=======
    redirect_to class_room_assignments_url(@class.id)
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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

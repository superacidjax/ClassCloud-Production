class DiscussionsController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@discussion, :title, :comment_create, :discussion

  log_activity_streams :current_user, :full_name, :started,
    :@discussion, :title, :create, :discussion

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class
<<<<<<< HEAD
  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = @class.discussions
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discussions }
    end
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @discussion }
    end
  end

  # GET /discussions/new
  # GET /discussions/new.json
  def new
    @discussion = Discussion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @discussion }
    end
  end

  # GET /discussions/1/edit
=======

  def index
    @discussions = @class.discussions
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = Discussion.new
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  def edit
    @discussion = Discussion.find(params[:id])
  end

<<<<<<< HEAD
  # POST /discussions
  # POST /discussions.json
=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.class_room_id = params[:class_room_id]

    if @discussion.save
      redirect_to (class_room_discussions_url(@class.id)), notice: 'Discussion was successfully created.'
    else
      render action: "new"
    end
  end

<<<<<<< HEAD
  # PUT /discussions/1
  # PUT /discussions/1.json
  def update
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      if @discussion.update_attributes(params[:discussion])
        format.html { redirect_to (class_room_discussions_url(@class.id)), notice: 'Discussion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy

    respond_to do |format|
      format.html { redirect_to (class_room_discussions_url(@class.id)) }
      format.json { head :ok }
    end
=======
  def update
    @discussion = Discussion.find(params[:id])

    if @discussion.update_attributes(params[:discussion])
      redirect_to (class_room_discussions_url(@class.id)), notice: 'Discussion was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    @discussion.destroy
    
    redirect_to (class_room_discussions_url(@class.id))
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end
  
  def comment_new
    @discussion = Discussion.find(params[:id])
  end

  def comment_create
    @discussion = Discussion.find(params[:id])
    @discussion.comments.create(params[:comment])
    redirect_to :back
  end


  def comment_destroy
    @discussion = Discussion.find(params[:id])
    comment = @discussion.comments.find(params[:comment_id])
    comment.destroy if comment
    render :action => "comment_new"
  end

  def comment_edit
    @discussion = Discussion.find(params[:id])
    @comment = @discussion.comments.find(params[:comment_id])
  end

  def comment_update
    @discussion = Discussion.find(params[:id])
    @comment = @discussion.comments.find(params[:comment_id])

    if params[:comment][:file].nil?
      params[:comment][:file] = @comment.file.path
    else
      params[:comment][:file]
    end
    if @comment.update_attributes(params[:comment])
      redirect_to class_room_discussions_url(@class.id)
    else
      render :action => "comment_edit"
    end
  end

  def download
    file = Comment.find(params[:id])
    send_file file.file.path, :type => file.file_content_type

  end

  def remove_file
    file = Comment.find(params[:id])
    if file.update_attributes(:file_updated_at =>'')
      redirect_to class_room_discussions_url(@class.id)
    else
      render :action => "comment_edit"
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

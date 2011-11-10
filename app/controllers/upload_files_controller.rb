class UploadFilesController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@upload_file, :title, :comment_create, :file

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class

  def index
    @notes = Comment.updated_not_null.commentable_type_note.user_id(current_user.id)
    @discussions = Comment.updated_not_null.commentable_type_discussion.user_id(current_user.id)
    @events = Event.updated_not_null.user_id(current_user.id)
    if params[:sorting_file].eql?('date_time')

      @upload_files = UploadFile.class_room(params[:class_room_id]).created_desc

    elsif params[:sorting_file].eql?('AZ')

      @upload_files = UploadFile.class_room(params[:class_room_id]).order("title ASC")

    elsif params[:category].eql?('documents')

     
      @upload_files = UploadFile.class_room(params[:class_room_id]).document_category.created_desc

    elsif params[:category].eql?('compress_files')

      @upload_files = UploadFile.class_room(params[:class_room_id]).file_name_category.created_desc

    elsif params[:category].eql?('images')
      @upload_files = UploadFile.class_room(params[:class_room_id]).image_category.created_desc
    elsif params[:category].eql?('pdf')
      
      @upload_files = UploadFile.class_room(params[:class_room_id]).pdf_category.created_desc
      
    else
      
      @upload_files = UploadFile.class_room(params[:class_room_id]).file_size_desc
    end
  end

  def show
    @upload_file = UploadFile.find(params[:id])
  end

  def new
    @upload_file = UploadFile.new
  end

  def edit
    @upload_file = UploadFile.find(params[:id])
  end

  def create
    @upload_file = UploadFile.new(params[:upload_file])

    respond_to do |format|
      if @upload_file.save
        format.html { redirect_to class_room_upload_files_url(@class.id), notice: 'Your file was successfully uploaded!' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @upload_file = UploadFile.find(params[:id])

    respond_to do |format|
      if @upload_file.update_attributes(params[:upload_file])
        format.html { redirect_to class_room_upload_files_url(@class.id), notice: 'Your file was successfully updated!' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @upload_file = UploadFile.find(params[:id])
    @upload_file.destroy

    respond_to do |format|
      format.html { redirect_to class_room_upload_files_url(@class.id) }
    end
  end

  def comment_new
    @upload_file = UploadFile.find(params[:id])
  end

  def comment_create
    @upload_file = UploadFile.find(params[:id])
    @upload_file.comments.create(:comment => params[:comment], :user_id => current_user.id)
    render :action => "comment_new"
  end


  def comment_destroy
    @upload_file = UploadFile.find(params[:id])
    comment =  @upload_file.comments.find(params[:comment_id])
    comment.destroy if comment
    render :action => "comment_new"
  end

  def comment_edit
    @upload_file = UploadFile.find(params[:id])
    @comment =  @upload_file.comments.find(params[:comment_id])
  end

  def comment_update
    @upload_file = UploadFile.find(params[:id])
    @comment =  @upload_file.comments.find(params[:comment_id])

    if @comment.update_attribute("comment", params[:comment])
      render :action => "comment_new"
    else
      render :action => "comment_edit"
    end
  end

  def download
    begin
    file = UploadFile.find(params[:id])
    send_file file.file.path, :type => file.file_content_type
    rescue
      flash[:notice] = "File not found"
      redirect_to :back
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

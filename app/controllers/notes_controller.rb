class NotesController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@note, :title, :comment_create, :note

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class

  def index
    @notes = @class.notes
  end

  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(params[:note])
    @note.class_room_id = @class.id

    if @note.save
      redirect_to class_room_notes_url(@class.id), notice: 'Note was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      redirect_to class_room_notes_url(@class.id), notice: 'Note was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    
    redirect_to(class_room_notes_url(@class.id))
  end
  
  def comment_new
    @note = Note.find(params[:id])
  end

  def comment_create
    @note = Note.find(params[:id])
    @note.comments.create(params[:comment])
    redirect_to comment_new_class_room_note_path(@class, params[:id])
  end
    

  def comment_destroy
    @note = Note.find(params[:id])
    comment = @note.comments.find(params[:comment_id])
    comment.destroy if comment
    redirect_to comment_new_class_room_note_path(@class, params[:id])
  end

  def comment_edit
    @note = Note.find(params[:id])
    @comment = @note.comments.find(params[:comment_id])
  end

  def comment_update
    @note = Note.find(params[:id])
    @comment = @note.comments.find(params[:comment_id])
    if params[:comment][:file].nil?
      params[:comment][:file] = @comment.file.path
    else
      params[:comment][:file]
    end
    if @comment.update_attributes(params[:comment])
      redirect_to comment_new_class_room_note_path(@class, params[:id])
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
      redirect_to class_room_notes_url(@class.id)
    else
      render :action => "comment_edit"
    end
  end

  def vote_up
    post = Note.find(params[:id])
    current_user.vote_for(post)
    respond_to do |format|
      format.html { redirect_to class_room_notes_url(@class.id) }
      format.json { head :ok }
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

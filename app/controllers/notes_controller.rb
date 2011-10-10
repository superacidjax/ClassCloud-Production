class NotesController < ApplicationController
  log_activity_streams :current_user, :full_name, :commented,
    :@note, :title, :comment_create, :note

  before_filter :authenticate_user!
  before_filter :get_my_students_and_class
<<<<<<< HEAD
<<<<<<< HEAD
  # GET /notes
  # GET /notes.json
=======

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # GET /notes
  # GET /notes.json
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def index
    @notes = @class.notes
  end

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
<<<<<<< HEAD
=======
  def show
    @note = Note.find(params[:id])
  end

  def new
    @note = Note.new
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def edit
    @note = Note.find(params[:id])
  end

<<<<<<< HEAD
<<<<<<< HEAD
  # POST /notes
  # POST /notes.json
=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # POST /notes
  # POST /notes.json
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def create
    @note = Note.new(params[:note])
    @note.class_room_id = @class.id

    if @note.save
      redirect_to class_room_notes_url(@class.id), notice: 'Note was successfully created.'
    else
      render action: "new"
    end
  end

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to class_room_notes_url(@class.id), notice: 'Note was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
<<<<<<< HEAD
=======
  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      redirect_to class_room_notes_url(@class.id), notice: 'Note was successfully updated.'
    else
      render action: "edit"
    end
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    respond_to do |format|
      format.html { redirect_to(class_room_notes_url(@class.id)) }
      format.json { head :ok }
    end
<<<<<<< HEAD
=======
    redirect_to(class_room_notes_url(@class.id))
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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

<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======

>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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
<<<<<<< HEAD
<<<<<<< HEAD

=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======

>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  
end

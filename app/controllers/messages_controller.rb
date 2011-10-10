class MessagesController < ApplicationController
  def index
    @inboxes = current_user.received_messages
    @files = MessageFile.where("user_id =?",current_user.id)
  end

  def sent
    @sent_mails = current_user.sent_messages
  end

  def edit
    @message = current_user.messages.with_id(params[:id]).first
    @users = User.all
  end
  
  def sent_detail
<<<<<<< HEAD
    @sent_detail=current_user.sent_messages
    @message_id=params[:id]
  end
  
  def update
    @sender=current_user
    if params[:chk_ids].nil?
      @sender.send_message(current_user ,params[:acts_as_messageable_message][:topic],params[:acts_as_messageable_message][:body])
    else
      @receivers=params[:chk_ids]
=======
    @sent_detail = current_user.sent_messages
    @message_id = params[:id]
  end
  
  def update
    @sender = current_user
    if params[:chk_ids].nil?
      @sender.send_message(current_user ,params[:acts_as_messageable_message][:topic],params[:acts_as_messageable_message][:body])
    else
      @receivers = params[:chk_ids]
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
      @receivers.each do |receiver|
        @receiver = User.find(receiver)
        @sender.send_message(@receiver ,params[:acts_as_messageable_message][:topic],params[:acts_as_messageable_message][:body])
      end
    end
<<<<<<< HEAD
    respond_to do |format|
      format.html { redirect_to(class_room_messages_url) }
      format.xml  { head :ok }
    end
=======
    redirect_to(class_room_messages_url)
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end

  def destroy
    @message = current_user.messages.with_id(params[:id]).first
    @message.destroy
    if params[:student_id]
      redirect_to student_observer_message_inbox_class_room_messages_url(@class, params[:student_id])
    elsif params[:teacher_id]
      redirect_to teacher_observer_message_inbox_class_room_messages_url(@class, params[:teacher_id])
    else
      redirect_to(class_room_messages_url)
    end
  end

  def new
    if current_user.is_teacher?
      @users = @students + @class.observers
    elsif current_user.is_student?
<<<<<<< HEAD
      @users=User.where("roles=?",[['teacher']])
    else
      @users=User.where("roles=?",[['teacher']])
=======
      @users = User.where("roles=?",[['teacher']])
    else
      @users = User.where("roles=?",[['teacher']])
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
    end
  end

  def create
<<<<<<< HEAD
    @sender=current_user
=======
    @sender = current_user
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
    unless (current_user.is_student? or current_user.is_observer?)
      if params[:chk_ids].nil?
        redirect_to :back
      else
        @receivers = params[:chk_ids]
        @file = params[:message][:file]
        @receivers.each do |receiver|
          @receiver = User.find(receiver)
          @sender.send_message(@receiver ,params[:message][:topic],params[:message][:body])
          unless params[:message][:file].nil?
            message_id = current_user.messages.are_to(receiver).last.id
            @message_file = MessageFile.create(:file => @file,:message_id =>message_id,:user_id =>receiver)
            @message_file.save
          end
        end
      end
    else
      @sender.send_message(@class.user, params[:message][:topic], params[:message][:body])
    end
    
    if params[:student_id]
      redirect_to(student_observer_message_inbox_class_room_messages_url(@class.id, params[:student_id]))
    elsif params[:teacher_id]
      redirect_to(teacher_observer_message_inbox_class_room_messages_url(@class.id, params[:teacher_id]))
    else
      redirect_to :back
    end
  end
  
  def draft
    @drafts=current_user.sent_messages
  end
  
  def draft_detail
    @draft_detail=current_user.sent_messages
    @message_id=params[:id]
  end
<<<<<<< HEAD
=======
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  def inbox_detail
    @message_id=params[:id]
    @inbox_detail=current_user.messages.where('id=?',@message_id).first
    @inbox_detail.opened=1
    @inbox_detail.save
  end

  def edit_draft
<<<<<<< HEAD
    
=======
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end
  
  def destroy_all_data
    @destroy_data = params[:chk_ids]
    
    @destroy_data.each do |inbox|
      @delete=current_user.messages.find(inbox)
      @delete.recipient_delete=1
      @delete.save
    end
    
<<<<<<< HEAD
    respond_to do |format|
      format.html { redirect_to(class_room_url(@class.id),:notice =>'.delete') }
      format.xml  { head :ok }
    end
=======
    redirect_to(class_room_url(@class.id),:notice =>'.delete')
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end

  def download
    file = MessageFile.find(params[:id])
    send_file file.file.path, :type => file.file_content_type
<<<<<<< HEAD

  end


=======
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
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

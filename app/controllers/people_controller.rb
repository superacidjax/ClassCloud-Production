class PeopleController < ApplicationController
  #  before_filter :authenticate_user!
  before_filter :teacher_required!
  skip_before_filter :teacher_required!, :only => [:pick_username_and_password, :save_username_and_password]
  before_filter :get_my_students_and_class, :except => [:pick_username_and_password, :save_username_and_password]

  def index
    @people = @students + @class.observers + [current_user]
  end

  def new
    @person = User.new
    @existing_observers = []
    @existing_students = []
    
    ClassRoom.where(["id <> ?", params[:class_room_id]]).each do |class_room|
      class_room.observers.each do |observer|
        @existing_observers << observer if observer.class_room_observers.where(class_room_id: params[:class_room_id]).blank?
      end
      class_room.students.each do |student|
        @existing_students << student if student.class_room_students.where(class_room_id: params[:class_room_id]).blank? and student.school_id.eql?(current_user.school_id)
      end
    end
  end

  def edit
    @person = User.find(params[:id])
    @person.user_type = @person.roles.first
  end

  def update
    @person = User.find(params[:id])
    @person.is_not_teacher = true
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

    if @person.update_attributes(params[:user])
      unless @person.roles.first.eql?(params[:user][:user_type])
        if @person.is_student?
          @person.class_room_students.destroy_all
          ClassRoomObserver.create(:user_id => @person.id, :class_room_id => @class.id)
        elsif @person.is_observer?
          @person.class_room_observers.destroy_all
          ClassRoomStudent.create(:user_id => @person.id, :class_room_id => @class.id)
        end
        @person.remove_role(@person.roles.first)
        @person.add_role(params[:user][:user_type])
        @person.save
      end
      redirect_to class_room_people_url(@class.id), notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def create
    already_user = User.where("email = ?", params[:user][:email]).first
    if already_user
      ClassRoomStudent.create(:user_id => already_user.id, :class_room_id => @class.id) if params[:user][:user_type].eql?("student")
      ClassRoomObserver.create(:user_id => already_user.id, :class_room_id => @class.id) if params[:user][:user_type].eql?("observer")
    redirect_to class_room_people_url(@class.id), notice: 'User was successfully created.'
    else

      @person = User.new(params[:user])
      @person.is_not_teacher = true
      @person.password = "123456"
      @person.password_confirmation = "123456"

      if @person.save
        @person.add_role params[:user][:user_type]
        @person.school_id = current_user.school_id
        @person.save
        ClassRoomStudent.create(:user_id => @person.id, :class_room_id => @class.id) if params[:user][:user_type].eql?("student")
        ClassRoomObserver.create(:user_id => @person.id, :class_room_id => @class.id) if params[:user][:user_type].eql?("observer")
        redirect_to class_room_people_url(@class.id), notice: 'User was successfully created.'
      else
        @existing_observers = []
        @existing_students = []
        ClassRoom.where(["id <> ?", params[:class_room_id]]).each do |class_room|
          class_room.observers.each do |observer|
            @existing_observers << observer
          end
          class_room.students.each do |student|
            @existing_students << student
          end
        end
        render action: "new"
      end
    end
  end

  def add_person_from_existing_people
    ClassRoomStudent.create(:user_id => params[:students], :class_room_id => @class.id) if params[:type].eql?("student") and !params[:students].blank?
    ClassRoomObserver.create(:user_id => params[:observers], :class_room_id => @class.id) if params[:type].eql?("observer") and !params[:observers].blank?
    redirect_to class_room_people_url(@class.id), notice: 'User was successfully created.'
  end

  def remove_from_class
    user = User.find(params[:id])
    if user.is_student?
      class_room_student = user.class_room_students.where(class_room_id: params[:class_room_id]).first
      class_room_student.destroy if class_room_student
    elsif user.is_observer?
      class_room_observer = user.class_room_observers.where(class_room_id: params[:class_room_id]).first
      class_room_observer.destroy if class_room_observer
    end
    redirect_to class_room_people_path(params[:class_room_id])
  end

  def pick_username_and_password
    @states = State.all
    @person = User.find_by_confirmation_token(params[:confirmation_token])
    render :layout => false
  end

  def save_username_and_password
    @person = User.find_by_confirmation_token(params[:confirmation_token])
    @person.user_pick_username_and_password = true
    
    if @person.update_attributes(params[:user])
      if params['state']['name'].nil?
        state = State.find_or_create_by_name_and_city(:name => params['state']['name2'], :city => params['state']['city2'])
        @person.state_id = state.id
      else
        @person.state_id = params['state']['name']
      end
      @person.save
      redirect_to user_confirmation_url(:confirmation_token => params[:confirmation_token], :user_save_username_and_password => true)
    else
      render action: "pick_username_and_password"
    end
  end

  def destroy
    @person = User.find(params[:id])
    @person.destroy
    redirect_to class_room_people_url(@class.id)
  end

  private

  def get_my_students_and_class
    @class = current_user.class_rooms.find(params[:class_room_id])
    @students = @class.students
  end

end

class Admin::AdminsController < ApplicationController
  layout 'admin'
  def index
    @teachers = User.where("roles =?",[["teacher"]])
    @students = User.where("roles =?",[["student"]])
    @observers = User.where("roles =?",[["observer"]])
<<<<<<< HEAD

  end
=======
  end

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  def edit
    @user = User.find(params[:id])
  end

<<<<<<< HEAD

  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
=======
  def new
    @user = User.new
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end

  def create
    @user = User.new(params[:user])
<<<<<<< HEAD
    @user.password = "123456"
    @user.password_confirmation = "123456"
    respond_to do |format|
      @user.is_not_teacher = true unless params[:user][:user_type].eql?("teacher")
      if @user.save
        
        if params[:user][:user_type].eql?("admin")
          @user.admin = 1
          @user.add_role params[:user][:user_type]
          @user.save
        elsif params[:user][:user_type].eql?("observer")
          @user.add_role 'observer'
          @user.save
        else
          @user.add_role 'teacher'
          @user.save
        end
        format.html { redirect_to (admin_admins_url), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
=======
    tmp = User.generate_random_string
    @user.password = tmp
    @user.password_confirmation = tmp

    @user.is_not_teacher = true unless params[:user][:user_type].eql?("teacher")
    if @user.save
        
      if params[:user][:user_type].eql?("admin")
        @user.admin = 1
        @user.add_role params[:user][:user_type]
        @user.save
      elsif params[:user][:user_type].eql?("observer")
        @user.add_role 'observer'
        @user.save
      else
        @user.add_role 'teacher'
        @user.save
      end
      redirect_to (admin_admins_url), notice: 'User was successfully created.'
    else
      render action: "new"
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
    end
  end

  def update
<<<<<<< HEAD
    params
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to (admin_admins_url), notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
=======
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to (admin_admins_url), notice: 'User was successfully updated.'
    else
      render action: "edit"
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

<<<<<<< HEAD
    respond_to do |format|
      format.html { redirect_to (admin_admins_url),notice: 'User was succesfully deleted'  }
      format.json { head :ok }
    end
=======
    redirect_to (admin_admins_url), notice: 'User was succesfully deleted'
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
  end

end


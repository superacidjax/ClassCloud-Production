class Admin::AdminsController < ApplicationController
  layout 'admin'
  def index
    @teachers = User.where("roles =?",[["teacher"]])
    @students = User.where("roles =?",[["student"]])
    @observers = User.where("roles =?",[["observer"]])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
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
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to (admin_admins_url), notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    redirect_to (admin_admins_url), notice: 'User was succesfully deleted'
  end

end


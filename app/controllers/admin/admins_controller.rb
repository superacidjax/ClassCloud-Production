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

  def school
    @states = State.where("name !=''")
    @countries = Country.where("name <>?",'USA')
  end

  def edit_school
    @school = School.find(params[:id])
    @city = City.find(@school.city_id)
    @state = State.find(@school.state_id)
    @states = State.where("name !=''")
    @cities = City.all
    @country = Country.find(@state.country_id)
    @countries = Country.all
    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city],:locals =>{:controller =>@controller,:country=>@countries}}

    end
  end

  def update_school
    city_name = City.find(params[:city][:name])
    state_name  = State.find(params[:state][:name])
    city = City.find(params[:city2])
    state = State.find(params[:id])
    school = School.find(params[:school])

    if params[:state][:name2].nil? and params[:state][:country2].nil? and params[:school][:name2].nil?
      city.update_attributes(:name =>city_name.name, :state_id =>state_name.id)
      city.save
      school.update_attributes(:state_id =>state_name.id, :city_id=>city_name.id)
      school.save
    else
      state = State.find_or_create_by_name_and_country(:name => params['state']['name2'], :country=> params['state']['country2'])
      city = City.find_or_create_by_name_and_state_id(:name =>params['city']['name2'],:state_id =>state.id)
      school.update_attributes(:name=>params['school']['name2'],:state_id =>state.id, :city_id =>city.id)
      school.save
    end
    redirect_to school_admin_admins_path
  end

  def new_school
  end

  def create_school
    state = State.find_or_create_by_name(:name =>params[:state])
    country = Country.find_or_create_by_name(:name =>params[:country])
    city = City.find_or_create_by_name(:name =>params[:city])
    school = School.new(:name=>params[:school],:state_id=>state.id, :city_id=>city.id)
    school.save
    redirect_to school_admin_admins_path
  end

end


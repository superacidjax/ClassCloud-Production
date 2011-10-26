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
      elsif params[:user][:user_type].eql?("observer")
        @user.add_role 'observer'
      else
        @user.add_role 'teacher'
      end
      @user.save
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
    @states = State.where("states.name !='' AND countries.name = 'USA'").joins(:country)
    @countries = Country.where("name <>?",'USA')
  end

  def edit_school
    @school = School.find(params[:id])
    @city = @school.city
    @state = @city.state
    @states = State.where("states.name <> ''")
    @cities = City.all
    @country = @state.country
    @countries = Country.all
    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city],:locals =>{:controller =>@controller,:country=>@countries}}

    end
  end

  def update_school
    school = School.find(params[:school])
    country = Country.find(params[:country_id])
    state = State.find(params[:id])
    city = City.find(params[:old_city])
    new_country = country
    
    if params[:country][:name2].nil?
      country_name = params[:country][:name]
    else
      country_name = params[:country][:name2]
    end
    
    if params[:country][:name].eql?(country.name) or params[:country][:name].nil?
      new_country.update_attribute(:name ,country.name)
    else
      new_country.update_attribute(:name ,country_name)
    end
    new_country.save
    
    unless params[:state][:name].nil?
      state_name = State.find(params[:state][:name])
    else
      state_name = State.find_or_create_by_name_and_country_id(:name =>params[:state][:name2], :country_id =>new_country.id)
    end
    
    if params[:city][:name].nil?
      school.update_attributes(:name => params[:new_school][:name], :state_id =>state_name.id, :city_id =>city.id)
    else
      new_city = City.find_or_create_by_name_and_state_id(:name =>params[:city][:name],:state_id =>state_name.id)
      school.update_attributes(:name => params[:new_school][:name], :state_id =>state_name.id, :city_id =>new_city.id)
    end
    school.save!
     
    redirect_to school_admin_admins_path
  end

  def new_school
  end

  def create_school
    country = Country.find_or_create_by_name(:name =>params[:country])
    state = State.find_or_create_by_name_and_country_id(:name =>params[:state],:country_id =>country.id)
    city = City.find_or_create_by_name_and_state_id(:name =>params[:city], :state_id => state.id)
    school = School.find_or_create_by_name_and_state_id_and_city_id(:name => params[:school],:state_id=>state.id, :city_id=>city.id)

    redirect_to school_admin_admins_path
  end

end


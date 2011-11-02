class PagesController < ApplicationController
  def index
  end

  def city
    @controller = params[:user_controller]
    
    if params[:user_controller].eql?('country')
      country =Country.find(params[:city])
      @states = country.states
      @cities = country.cities
    else
      @cities = City.where("state_id = ?", params[:city])
    end
    
    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city],:locals =>{:controller =>@controller,:country=>country}}

    end
  end

  def school
    if params[:user_controller].eql?('country')
      city = City.find(params[:school])
      @schools = School.where("city_id = ? AND name !=''", city.id)
    else
      @schools = School.where("city_id = ? AND name !=''", params[:school])
    end

    respond_to do |format|
      format.html{render :layout => false}

    end
  end

  def country
    @country = Country.search_by_country(params[:q])

    if @country.blank?
      render :json => []
    else
      render :json =>@country.json_form
    end
    
  end

  def city_list
    @country = Country.find(params[:country_id])
    @cities = @country.cities.where("name IS NOT NULL AND name !=''")
    @states  = State.where("countries.name = ? AND states.name !=''",'USA').includes(:country)
    
     
    respond_to do |format|
      format.html{render :layout => false}
    end
  end

  def state_list
    @states = State.where("name !='' AND name = ?",'USA')

    respond_to do |format|
      format.html{render :layout => false}
    end
  end
end

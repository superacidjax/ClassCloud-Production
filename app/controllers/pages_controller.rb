class PagesController < ApplicationController
  def index
  end

  def city
    if params[:user_controller].eql?('country')
      country =Country.find(params[:city])
      @states = country.states
    else
      @cities = City.where("state_id = ?", params[:city])
    end
    
    @controller = params[:user_controller]
    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city],:locals =>{:controller =>@controller,:country=>country}}

    end
  end

  def school
    if params[:user_controller].eql?('country')
      city = City.find(params[:school])
      @schools = School.where("city_id = ?", city.id)
    else
      @schools = School.where("city_id = ?", params[:school])
    end
    respond_to do |format|
      format.html{render :layout => false}

    end
  end

  def country
    @country = Country.search_by_country(params[:q])
    require 'pp'

    pp @country
    if @country.blank?
      render :json => []
    else
      render :json =>@country.json_form
    end
    
  end
end

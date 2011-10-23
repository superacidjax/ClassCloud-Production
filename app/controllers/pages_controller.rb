class PagesController < ApplicationController
  def index
  end

  def city
    @cities = City.where("state_id = ?", params[:city])
    @controller = params[:user_controller]
    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city],:locals =>{:controller =>@controller}}

    end
  end

  def school
    @schools = School.where("state_id = ?", params[:school])

    respond_to do |format|
      format.html{render :layout => false}

    end
  end

  def search_state

  end
end

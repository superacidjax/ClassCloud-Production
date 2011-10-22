class PagesController < ApplicationController
  def index
  end

  def city
    @cities = State.where("id = ?", params[:city])

    respond_to do |format|
      format.html{render :layout => false,:state_name =>params[:city]}

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

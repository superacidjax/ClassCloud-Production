class PagesController < ApplicationController
  def index
  end
  def city
  @cities = State.find(params[:city])

    respond_to do |format|
      format.html{render :layout => false}

    end
  end
end

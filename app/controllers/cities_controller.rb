class CitiesController < ApplicationController

  def filtercity
    @cities = City.all.order(name: :asc)
    @city = City.find(params[:id])
    @advertisements = Advertisement.where(location: @city.name).paginate(page: params[:page], per_page: 10).order("created_at DESC")
    if current_user.present?
      @favourites = current_user.favourites
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end

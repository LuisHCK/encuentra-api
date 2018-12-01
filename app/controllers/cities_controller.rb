class CitiesController < ApplicationController
  def index
    @cities = City.where(country_id: 1)
    render json: @cities
  end

  def show
    @city = City.find(params[:id])
    render json: @city
  end
end

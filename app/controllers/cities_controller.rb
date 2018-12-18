class CitiesController < ApplicationController
  def index
    @cities = nil
    if params[:country_id].present?
      @cities = City.where(country_id: params[:country_id])
    else
      @cities = City.all
    end
    render json: @cities
  end

  def show
    @city = City.find(params[:id])
    render json: @city
  end
end

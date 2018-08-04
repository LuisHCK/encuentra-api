class CountriesController < ApplicationController
  before_action :set_country, only: [:show]

  # Render all Countries
  def index
    countries = Country.all
    json_string = CountriesSerializer.new(countries).serialized_json
    render json: json_string
  end

  def show  
    if @country.present?
      render json: CountriesSerializer.new(@country, include: [:cities, :'cities.name']).serialized_json
    else
      head :not_found
    end
  end

  private

  def set_country
    @country = Country.find_by(id: params[:id])
  end

  
end

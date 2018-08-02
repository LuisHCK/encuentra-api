class CountriesController < ApplicationController

  # Render all Countries
  def index
    countries = Country.all
    json_string = CountriesSerializer.new(countries).serialized_json
    render json: json_string
  end

  
end

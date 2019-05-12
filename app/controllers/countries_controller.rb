class CountriesController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_country, only: [:show]

  # Render all Countries
  def index
    countries = Country.all
    render json: countries
  end

  def show
    if @country.present?
      render json: CountrySerializer.new(@country, include: [:cities, :'cities.name']).as_json
    else
      head :not_found
    end
  end

  private

  def set_country
    @country = Country.find_by(id: params[:id])
  end
end

class FavoritesController < ApplicationController
  before_action :authenticate_user
  before_action :set_favorite, only: [:show, :update, :destroy]

  # GET /favorites
  def index
    @favorites = current_user.favorites.all

    render json: @favorites
  end

  # GET /favorites/1
  def show
    render json: @favorite
  end

  # POST /favorites
  def create
    @favorite = Favorite.new(favorite_params)

    if favorite_not_exists? && @favorite.save
      render json: @favorite, status: :created, location: @favorite
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /favorites/1
  def update
    render json: @favorite.errors, status: :unprocessable_entity
  end

  # DELETE /favorites/1
  def destroy
    @favorite.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_favorite
    @favorite = current_user.favorites.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def favorite_params
    params.require(:favorite).permit(:user_id, :room_id)
  end

  def favorite_not_exists?
    fav = params[:favorite]
    unless Favorite.find_by(room_id: fav[:room_id], user_id: fav[:user_id])
      return true
    end
  end
end

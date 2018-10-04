class RoomsController < ApplicationController
  before_action :authenticate_user, except: [:create]
  before_action :set_room, only: [:update, :destroy, :set_state]

  # GET /rooms
  def index
    @rooms = Room.all

    render json: @rooms
  end

  # GET /rooms/1
  def show
    render json: Room.find(params[:id])
  end

  # POST /rooms
  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      render json: @room, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  def destroy
    @room.destroy
  end

  # Set state
  def set_state
    if params.state
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = current_user.rooms.find_by(id: params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def room_params
    params.require(:room).permit(:title, :description, :price, :lat, :lng, :user_id, :zone_id)
  end
end

class RoomsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_room, only: [:update, :destroy, :set_state]

  # GET /rooms
  def index
    @rooms = Room.all
    render json: serialize!(@rooms, params, "Room")
  end

  # GET /rooms/1
  def show
    render json: serialize!(Room.find(params[:id]))
  end

  # POST /rooms
  def create
    @room = current_user.rooms.new(room_params)

    if @room.save
      render json: serialize!(@room), status: :created
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
    if state_is_valid?
      @room.send(params[:state] + "!")
      render json: serialize!(@room)
    else
      errors = [
        {
          "status": "422",
          "title": "Invalid State",
          "detail": "The state is not valid.",
        },
      ]
      render json: errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = current_user.rooms.find_by(id: params[:id] || params[:room_id])
  end

  # Only allow a trusted parameter "white list" through.
  def room_params
    params.require(:room).permit(
      :title,
      :description,
      :price,
      :lat,
      :lng,
      :user_id,
      :zone_id,
      :include
    )
  end

  def json_api_params
    params.permit(include: [], filter: [], fields: [])
    # begin
    #   return {
    #            include: JSON.parse(params[:include]),
    #            filter: JSON.parse(params[:filter]),
    #            fields: JSON.parse(params[:fields]),
    #          }
    # rescue => exception
    #   return {}
    # end
  end

  # Filter state
  def state_is_valid?
    valid_states = %w(to_published to_rented to_draft)
    valid_states.include? params[:state]
  end
end

class RoomsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_room, only: [:update, :destroy, :set_state]

  # GET /rooms
  def index
    if params[:promoted].present?
      @rooms = Room.where(promoted: ["gold", "silver"]).limit(10)
      return render json: @rooms
    else
      @rooms = Room.where(promoted: "none").page(params[:page]).per(10)
      return serialize_rooms @rooms
    end
  end

  # GET user rooms => user/:id/rooms
  def user_rooms
    @rooms = Room.where(user_id: params[:user_id]).page(params[:page]).per(10)
    serialize_rooms @rooms
  end

  # GET /rooms/1
  def show
    @room = Room.find(params[:id])
    render json: @room
  end

  def meetings
    @room = current_user.rooms.find(params[:room_id])
    render json: @room.meetings.where(state: "pending")
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
    if state_is_valid?
      @room.send(params[:state] + "!")
      render json: @room
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
    permited = [:title,
                :description,
                :price,
                :lat,
                :lng,
                :zone_id,
                :category_id,
                :address,
                :currency,
                :phones,
                :services,
                photos: []]
    if params[:usealt] == true || params[:usealt] == "true"
      params.permit(permited)
    else
      params.require(:room).permit(permited)
    end
  end

  # Filter state
  def state_is_valid?
    valid_states = %w(to_published to_rented to_draft)
    valid_states.include? params[:state]
  end

  def serialize_rooms(rooms)
    return render json: {
                    rooms: ActiveModelSerializers::SerializableResource.new(
                      rooms
                    ).as_json,
                    pages: {
                      prev: rooms.prev_page,
                      next: rooms.next_page,
                      total: rooms.total_pages,
                    },
                  }
  end
end

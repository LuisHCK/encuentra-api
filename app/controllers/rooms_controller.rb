class RoomsController < ApplicationController
  before_action :authenticate_user, except: [:show, :index]
  before_action :set_room, only: [:update, :destroy, :set_state]

  # GET /rooms
  def index
    if params[:promoted].present?
      @rooms = Room.where(promoted: ["1-gold", "2-silver"], state: "published")
        .order("promoted").limit(10)
      return render json: @rooms
    elsif params[:search].present?
      # Search request
      paginate_rooms full_search
    else
      @rooms = Room.where(promoted: "3-none", state: "published")
        .page(params[:page]).per(10)
      return paginate_rooms @rooms
    end
  end

  # GET user rooms => user/:id/rooms
  def user_rooms
    @rooms = Room.where(user_id: params[:user_id], state: "published")
      .page(params[:page]).per(10)
    paginate_rooms @rooms
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
    # Parse json strings if it's necesary
    @room.phones = JSON.parse(@room.phones) if @room.phones.is_a?(String)
    @room.services = JSON.parse(@room.services) if @room.services.is_a?(String)

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
      # When use alt don't require an json structured payload
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

  # Execute full search scope in Room
  def full_search
    Room.full_search(params[:search])
      .where(state: "published")
      .order("promoted ASC")
      .page(params[:page]).per(10)
  end

  def paginate_rooms(rooms)
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

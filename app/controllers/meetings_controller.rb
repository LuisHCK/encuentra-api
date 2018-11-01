class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :update, :destroy, :set_state]

  # GET /meetings
  def index
    @meetings = Meeting.where(room_id: params[:room_id]).all()

    render json: serialize!(@meetings, params, "Meeting")
  end

  # GET /meetings/1
  def show
    render json: serialize!(@meeting, params)
  end

  # POST /meetings
  def create
    @meeting = Meeting.new(meeting_params)

    if Meeting.where(room_id: params[:room_id], user_id: params[:meeting][:user_id]).any?
      @meeting.errors.add(:room_id, "A meeting has already been scheduled for this room")
      return render json: @meeting.errors, status: :unprocessable_entity
    end

    if @meeting.save
      render json: serialize!(@meeting, params), status: :created
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      render json: serialize!(@meeting, params)
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meetings/1
  def destroy
    @meeting.destroy
  end

  def set_state
    if state_is_valid?
      @meeting.send(params[:state] + "!")
      render json: serialize!(@meeting, params)
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
  def set_meeting
    @room = Room.find(params[:room_id])
    @meeting = @room.meetings.find(params[:id] || params[:meeting_id])
  end

  # Only allow a trusted parameter "white list" through.
  def meeting_params
    params.require(:meeting).permit(:user_id, :room_id, :date_time, :message, :state)
  end

  # Filter state
  def state_is_valid?
    valid_states = %w(to_accepted to_rejected to_finished)
    valid_states.include? params[:state]
  end
end

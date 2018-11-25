class MeetingsController < ApplicationController
  before_action :authenticate_user
  before_action :set_meeting, only: [:show, :update, :destroy, :set_state]

  # GET /meetings
  def index
    @meetings = current_user.meetings.all()

    render json: @meetings
  end

  # GET /meetings/1
  def show
    render json: @meeting, include: "room.zone"
  end

  # POST /meetings
  def create
    @meeting = current_user.meetings.new(meeting_params)

    if Meeting.where(room_id: params[:room_id], user_id: current_user.id).any?
      @meeting.errors.add(:room_id, "A meeting has already been scheduled for this room")
      return render json: @meeting.errors, status: :unprocessable_entity
    end

    if @meeting.save
      render json: @meeting, status: :created
    else
      render json: @meeting.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meetings/1
  def update
    if @meeting.update(meeting_params)
      render json: @meeting
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
      render json: @meeting
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
    @meeting = current_user.meetings.find(params[:id] || params[:meeting_id])
  end

  # Only allow a trusted parameter "white list" through.
  def meeting_params
    params.require(:meeting).permit(:room_id, :date_time, :message, :phone)
  end

  # Filter state
  def state_is_valid?
    valid_states = %w(to_accepted to_rejected to_finished)
    valid_states.include? params[:state]
  end
end

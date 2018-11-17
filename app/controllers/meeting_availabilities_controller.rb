class MeetingAvailabilitiesController < ApplicationController
  before_action :set_meeting_availability, only: [:show, :update, :destroy]

  # GET /meeting_availabilities
  def index
    @meeting_availabilities = MeetingAvailability.all

    render json: @meeting_availabilities
  end

  # GET /meeting_availabilities/1
  def show
    render json: @meeting_availability
  end

  # POST /meeting_availabilities
  def create
    @meeting_availability = MeetingAvailability.new(meeting_availability_params)

    if @meeting_availability.save
      render json: @meeting_availability, status: :created, location: @meeting_availability
    else
      render json: @meeting_availability.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /meeting_availabilities/1
  def update
    if @meeting_availability.update(meeting_availability_params)
      render json: @meeting_availability
    else
      render json: @meeting_availability.errors, status: :unprocessable_entity
    end
  end

  # DELETE /meeting_availabilities/1
  def destroy
    @meeting_availability.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_availability
      @meeting_availability = MeetingAvailability.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meeting_availability_params
      params.require(:meeting_availability).permit(:date_from, :date_to, :time_from, :time_to, :skip_weekends, :room_id)
    end
end

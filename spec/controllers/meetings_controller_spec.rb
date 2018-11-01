require "rails_helper"

RSpec.describe MeetingsController, type: :controller do
  let(:publisher) { create(:publisher) }

  let(:user) { create(:user) }

  let(:room) { create(:room, user: user, zone: create(:zone)) }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:meeting, room_id: room.id, user_id: user.id)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:meeting, date_time: nil, room_id: room.id, user_id: user.id)
  }

  describe "GET #index" do
    it "returns a success response" do
      # meeting = Meeting.create! valid_attributes
      api_auth(request, user)
      get :index, params: {room_id: room.id}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      meeting = Meeting.create! valid_attributes

      api_auth(request, user)
      get :show, params: {room_id: room.to_param, id: meeting.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Meeting" do
        api_auth(request, user)
        expect {
          post :create, params: {room_id: room.to_param, meeting: valid_attributes}
        }.to change(Meeting, :count).by(1)
      end

      it "renders a JSON response with the new meeting" do
        api_auth(request, user)
        post :create, params: {room_id: room.to_param, meeting: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new meeting" do
        api_auth(request, user)
        post :create, params: {room_id: room.to_param, meeting: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:meeting, date_time: Time.now + 2.hours)
      }

      it "updates the requested meeting" do
        meeting = Meeting.create! valid_attributes

        api_auth(request, user)
        put :update, params: {room_id: room.to_param, id: meeting.to_param, meeting: new_attributes}
        meeting.reload
        expect(meeting.date_time.utc).to be_within(60.seconds).of(Time.now + 2.hours)
      end

      it "renders a JSON response with the meeting" do
        meeting = Meeting.create! valid_attributes

        api_auth(request, user)
        put :update, params: {room_id: room.to_param, id: meeting.to_param, meeting: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the meeting" do
        meeting = Meeting.create! valid_attributes

        api_auth(request, user)
        put :update, params: {room_id: room.to_param, id: meeting.to_param, meeting: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested meeting" do
      meeting = Meeting.create! valid_attributes
      api_auth(request, user)
      expect {
        delete :destroy, params: {room_id: room.to_param, id: meeting.to_param}
      }.to change(Meeting, :count).by(-1)
    end
  end

  describe "PATCH #set_state" do
    it "change state to accepted" do
      meeting = Meeting.create! valid_attributes
      api_auth(request, user)

      patch :set_state, params: {room_id: room.to_param, meeting_id: meeting.to_param, state: "to_accepted"}
      expect(response).to have_http_status(:ok)
    end
  end
end

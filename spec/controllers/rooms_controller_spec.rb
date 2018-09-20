require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user) }

  let(:country) { create(:country) }

  let(:city) { create(:city, country: country) }

  let(:zone) { create(:zone, city: city) }

  let(:valid_attributes) { FactoryBot.attributes_for(:room, user: user, zone: zone) }

  let(:invalid_attributes) { FactoryBot.attributes_for(:room) }

  describe "GET #index" do
    it "returns a success response" do
      room = Room.create! valid_attributes
      api_auth(request, user)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      room = Room.create! valid_attributes
      api_auth(request, user)
      get :show, params: {id: room.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Room" do
        api_auth(request, user)
        expect {
          post :create, params: {room: valid_attributes}
        }.to change(Room, :count).by(1)
      end

      it "renders a JSON response with the new room" do
        api_auth(request, user)
        post :create, params: {room: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(room_url(Room.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new room" do
        api_auth(request, user)
        post :create, params: {room: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested room" do
        room = Room.create! valid_attributes
        api_auth(request, user)
        put :update, params: {id: room.to_param, room: new_attributes}
        room.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the room" do
        room = Room.create! valid_attributes

        api_auth(request, user)
        put :update, params: {id: room.to_param, room: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the room" do
        room = Room.create! valid_attributes

        api_auth(request, user)
        put :update, params: {id: room.to_param, room: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested room" do
      room = Room.create! valid_attributes
      api_auth(request, user)
      expect {
        delete :destroy, params: {id: room.to_param}
      }.to change(Room, :count).by(-1)
    end
  end
end

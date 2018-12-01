require "rails_helper"

RSpec.describe RoomsController, type: :controller do
  let(:country) { create(:country) }

  let(:user) { create(:publisher, country: country) }

  let(:city) { create(:city, country: country) }

  let(:zone) { create(:zone, city: city) }

  let(:category) { create(:category) }

  let(:valid_attributes) {
    FactoryBot.attributes_for(
      :room,
      user_id: user.id,
      zone_id: zone.id,
      category_id: category.id,
    )
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(
      :room,
      title: nil,
      description: nil,
      category_id: category.id,
    )
  }

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
        FactoryBot.attributes_for(:room, title: "newtitle")
      }

      it "updates the requested room" do
        room = Room.create! valid_attributes
        api_auth(request, user)
        put :update, params: {id: room.to_param, room: new_attributes}
        room.reload
        expect(room.title).to eq("newtitle")
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

  describe "UPDATE #set_state" do
    it "transition state from DRAFT to PUBLISHED" do
      room = Room.create! valid_attributes
      api_auth request, user
      put :set_state, params: {
                        room_id: room.to_param,
                        state: "to_published",
                      }
      room.reload
      expect(response).to have_http_status(:ok)
      expect(room.state).to eq("published")
    end
  end
end

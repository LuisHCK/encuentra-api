require "rails_helper"

RSpec.describe ZonesController, type: :controller do
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }
  let(:user) { create(:admin, city: city) }
  let(:valid_attributes) { FactoryBot.attributes_for(:zone, city_id: city.id) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:zone, latitude: nil, longitude: nil, city: city) }

  describe "GET #index" do
    it "return a success response" do
      zone = Zone.create! valid_attributes
      api_auth(request, user)
      get :index, params: {city_id: city.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      zone = Zone.create! valid_attributes
      api_auth(request, user)
      get :show, params: {city_id: city.to_param, id: zone.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Zone" do
        api_auth(request, user)
        post :create, params: {city_id: city.to_param, zone: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "render a JSON response with errors for the new Zone" do
        api_auth(request, user)
        post :create, params: {city_id: city.to_param, zone: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { FactoryBot.attributes_for(:zone, latitude: 2.2, longitude: 2.2, name: "new_zone") }

      it "updates the requested zone" do
        zone = Zone.create! valid_attributes
        api_auth(request, user)
        put :update, params: {city_id: city.to_param, id: zone.to_param, zone: new_attributes}
        zone.reload
        expect(zone.name).to eq("new_zone")
        expect(zone.latitude).to eq(2.2)
        expect(zone.longitude).to eq(2.2)
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "render a JSON response with error for the updated zone" do
        zone = Zone.create! valid_attributes
        api_auth(request, user)
        put :update, params: {city_id: city.to_param, id: zone.to_param, zone: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested zone" do
      zone = Zone.create! valid_attributes
      api_auth(request, user)
      expect {
        delete :destroy, params: {city_id: city.to_param, id: zone.to_param}
      }.to change(Zone, :count).by(-1)
    end
  end
end

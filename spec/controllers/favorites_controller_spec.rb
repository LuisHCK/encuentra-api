require "rails_helper"

RSpec.describe FavoritesController, type: :controller do
  let(:country) { create(:country) }

  let(:publisher) { create(:publisher, country: country) }

  let(:category) { create(:category) }

  let(:city) { create(:city, country: country) }

  let(:user) { create(:user, city: city) }

  let(:zone) { create(:zone, city: city) }

  let(:room) { create(:room, user: user, zone: zone, category: category) }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:favorite, room_id: room.id, user_id: user.id)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:favorite, room_id: room.id, user_id: 0)
  }

  describe "GET #index" do
    it "returns a success response" do
      favorite = Favorite.create! valid_attributes
      api_auth(request, user)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      favorite = Favorite.create! valid_attributes
      api_auth(request, user)
      get :show, params: {id: favorite.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Favorite" do
        api_auth(request, user)
        expect {
          post :create, params: {favorite: valid_attributes}
        }.to change(Favorite, :count).by(1)
      end

      it "renders a JSON response with the new favorite" do
        api_auth(request, user)
        post :create, params: {favorite: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.location).to eq(favorite_url(Favorite.last))
      end

      it "returns an error when favorite exists" do
        favorite = Favorite.create! valid_attributes
        api_auth(request, user)
        post :create, params: {favorite: valid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new favorite" do
        api_auth(request, user)
        post :create, params: {favorite: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "favorite can't be updated" do
      it "renders a JSON response with errors for the favorite" do
        favorite = Favorite.create! valid_attributes
        api_auth(request, user)
        put :update, params: {id: favorite.to_param, favorite: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested favorite" do
      api_auth(request, user)
      favorite = Favorite.create! valid_attributes
      expect {
        delete :destroy, params: {id: favorite.to_param}
      }.to change(Favorite, :count).by(-1)
    end
  end
end

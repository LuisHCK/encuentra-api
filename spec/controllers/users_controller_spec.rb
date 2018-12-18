require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:country) { create(:country) }
  let(:city) { create(:city, country: country) }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:user, city_id: city.id)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(
      :user,
      name: nil,
      lastname: nil,
      username: nil,
      email: nil,
      city_id: city.id,
    )
  }

  describe "GET #index" do
    it "returns a success response" do
      user = User.create! valid_attributes
      api_auth(request, user)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = User.create! valid_attributes
      api_auth(request, user)
      get :show, params: {id: user.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}
        }.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: {user: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new user" do
        post :create, params: {user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        FactoryBot.attributes_for(:user, name: "newname")
      }

      it "updates the requested user" do
        user = User.create! valid_attributes
        api_auth(request, user)
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
        expect(user.name).to eq("newname")
      end

      it "renders a JSON response with the user" do
        user = User.create! valid_attributes

        api_auth(request, user)
        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes

        api_auth(request, user)
        put :update, params: {id: user.to_param, user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      api_auth(request, user)
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end
end

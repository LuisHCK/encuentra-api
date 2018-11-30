Rails.application.routes.draw do
  get 'cities/index'
  resources :meeting_availabilities
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  # Resources
  resources :categories

  resources :rooms do
    patch "set_state", to: "rooms#set_state"
  end

  resources :meetings do
    patch "set_state", to: "meetings#set_state"
  end

  resources :users do
    get "rooms", to: "rooms#user_rooms"
  end

  resources :zones do
  end

  get "cities", to: "cities#index"

  # Authentication
  post "auth/basic" => "user_token#create"
  post "auth/facebook_auth", to: "facebook#authenticate"

  # Countries Actions
  get "/countries" => "countries#index"
  get "/countries/:id" => "countries#show"
end

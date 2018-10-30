Rails.application.routes.draw do
  resources :rooms do
    put "set_state", to: "rooms#set_state"
  end

  resources :users

  resources :zones do
  end

  # Authentication
  post "auth/basic" => "user_token#create"
  post "auth/facebook_auth", to: "facebook#authenticate"

  # Countries Actions
  get "/countries" => "countries#index"
  get "/countries/:id" => "countries#show"
end

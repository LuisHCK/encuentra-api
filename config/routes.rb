Rails.application.routes.draw do
  resources :rooms do
    put "set_state", to: "rooms#set_state"
  end

  resources :users

  namespace :auth do
    post "basic" => "user_token#create"
    post "facebook_auth", to: "facebook#authenticate"
  end

  # Countries Actions
  get "/countries" => "countries#index"
  get "/countries/:id" => "countries#show"
end

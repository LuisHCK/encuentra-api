Rails.application.routes.draw do
  resources :favorites
  get "cities/index"
  resources :meeting_availabilities
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  
  # Resources
  resources :categories
  
  resources :rooms do
    patch "set_state", to: "rooms#set_state"
    get "meetings", to: "rooms#meetings"
  end
  
  resources :meetings do
    patch "set_state", to: "meetings#set_state"
  end
  
  resources :users do
    get "rooms", to: "rooms#user_rooms"
  end
  
  resources :cities do
    resources :zones
  end
  
  resources :chats

  # Authentication
  post "auth/basic" => "user_token#create"

  namespace :auth do
    post "/facebook", to: "facebook#authenticate"
  end

  # Countries Actions
  get "/countries" => "countries#index"
  get "/countries/:id" => "countries#show"
end

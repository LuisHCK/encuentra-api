Rails.application.routes.draw do
  resources :rooms
  resources :users
  post "auth" => "user_token#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :auth do
    post "facebook_auth", to: "facebook#authenticate"
  end

  # Countries Actions
  get "/countries" => "countries#index"
  get "/countries/:id" => "countries#show"
end

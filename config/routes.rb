Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :locations, only: [:index, :show]

  resources :trips, only: [:index, :show, :create] do
    resources :itineraries, only: [:create]
  end

  resources :itineraries, only: [:index, :update]
end

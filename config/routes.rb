Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :locations, only: [:index, :show] do
    collection do
      get :my_favorites
    end
    member do
      post 'favorite'
    end
    resources :user_reviews, only: [:new, :create]
  end

  resources :trips, only: [:index, :show, :create, :update] do
    resources :itineraries, only: [:create]
    member do
      get 'generate_icalendar'
    end
  end

  patch 'itineraries/', to: 'itineraries#update_all', as: 'update_all'
  get '/trips/:id/generate', to: 'trips#generate', as: 'generate_trip'

  resources :itineraries, only: [:index, :update, :destroy]
end

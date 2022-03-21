Rails.application.routes.draw do

  root "topics#index"

  # Topics routes
  resources :topics do
    resources :posts
  end

  resources :posts do
    resources :likes
  end

  # User routes
  resources :users, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :inboxes
  end

  # Sessions routes
  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/logout', to: 'sessions#destroy'
  delete '/logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end

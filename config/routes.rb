Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :likes
  resources :team_events
  get "/" , to: 'users#home'
  resources :bets
  resources :teams
  resources :replies
  resources :comments
  resources :users
  resources :games
  # resources :sessions, only: [:create]
  patch 'close_event', to:  'games#close_event'
  patch '/reset', to: 'team_events#reset_event'
  get '/login', to: 'sessions#new'
  post '/login',    to: 'sessions#login'
  post '/adminlogin',    to: 'sessions#create'
  post '/signout',   to: 'sessions#log_out'
  get '/islogged_in',to: 'sessions#show'
  delete '/signout', to: 'sessions#destroy'
end

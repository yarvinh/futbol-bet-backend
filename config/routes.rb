Rails.application.routes.draw do
  resources :leagues
  resources :teams
  resources :images
  resources :likes
  resources :team_events
  get "/" , to: 'users#home'
  # resources :bets
  resources :teams
  resources :users
  resources :games do
    resources :bets
    resources :comments do
      resources :replies
    end
  end
  patch 'close_event', to:  'games#close_event'
  patch '/reset', to: 'team_events#reset_event'
  get '/login', to: 'sessions#new'
  post '/login',    to: 'sessions#login'
  post '/adminlogin',    to: 'sessions#create'
  post '/signout',   to: 'sessions#log_out'
  get '/islogged_in',to: 'sessions#show'
  delete '/signout', to: 'sessions#destroy'
  get "/search_league_teams", to: 'teams#search_league_teams'
end

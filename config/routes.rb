Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  get '/redirect/:event_id', to: 'calendar#redirect', as: 'redirect'
  get '/callback', to: 'calendar#callback', as: 'callback'
  # get '/calendars', to: 'calendar#calendars', as: 'calendars'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :events do 
    resources :attendees, only: [:create, :destroy]
  end

  root 'home#index'
end

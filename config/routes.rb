Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :events do 
    resources :attendees, only: [:create, :destroy]
  end
  root 'home#index'
end

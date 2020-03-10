Rails.application.routes.draw do
  root 'static_pages#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get '/signup',  to: 'users#new'
  get '/login',   to: 'sessions#new'
  post'/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'homes/index'

  resources :users
  resources :account_activations
  resources :homes
  resources :password_resets
end

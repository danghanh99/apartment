Rails.application.routes.draw do
  root 'static_pages#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get '/help',    to: 'static_pages#help'
  get '/signup',  to: 'users#new'
  get '/login',   to: 'sessions#new'
  post'/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/search' => 'static_pages#index', :as => 'search_page'
  get '/search-price' => 'static_pages#index_price', :as => 'search_price'


  resources :users
  resources :account_activations
  resources :homes
  resources :password_resets
end

Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "sessions/new"
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "homes#index"
  get "/orders", to: "orders#index"
  resources :orders do
    patch "/deny", to: "orders#deny"
    patch "/approved", to: "orders#approved"
  end
  resources :users do
    get "/profile", to: "users#profile"
  end
  resources :account_activations
  resources :homes do
    resources :orders
  end
  resources :password_resets
end

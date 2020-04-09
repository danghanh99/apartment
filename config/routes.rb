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
    post "/create_extension", to: "orders#create_extension"
    patch "/deny", to: "orders#deny"
    patch "/approve", to: "orders#approve"
    patch "/cancel", to: "orders#cancel"
    patch "/edit", to: "orders#edit"
    patch "/finish", to: "orders#finish"
    get "/new_extension", to: "orders#new_extension"
    get "/detail", to: "orders#detail"
  end
  resources :users do
    get "/profile", to: "users#profile"
  end
  resources :account_activations
  resources :homes do
    #post "/create_extension", to: "orders#create_extension"
    get "/detail", to: "homes#detail"
    resources :orders
    resources :rooms
  end

  resources :rooms do
    # post "/create_extension", to: "orders#create_extension"
    get "/detail", to: "rooms#detail"
    resources :orders
  end
  resources :password_resets
end

Rails.application.routes.draw do
  get '/pages/:title', to: 'pages#show', as: 'about_page'
  get '/pages/:title', to: 'pages#show', as: 'contact_page'
  get "orders/new"
  get "orders/create"
  get "ordered_products/index"
  get "ordered_products/show"
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :pages
  resources :products
  resources :categories
  resources :carts do
    match "add_to_cart/:id", action: :add_to_cart, on: :member, via: %i[get post],
as: :add_to_cart
    match "remove_from_cart/:id", action: :remove_from_cart, on: :member,
via: %i[get post], as: :remove_from_cart
  end

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "search", to: "products#search", as: :search
  # Defines the root path route ("/")
  root "products#index"
end

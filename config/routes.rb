Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :products
  resources :categories
  resources :carts do
    match "add_to_cart/:id", action: :add_to_cart, on: :member, via: %i[get post],
as: :add_to_cart
    match "remove_from_cart/:id", action: :remove_from_cart, on: :member,
via: %i[get post], as: :remove_from_cart
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "search", to: "products#search", as: :search
  # Defines the root path route ("/")
  root "products#index"
end

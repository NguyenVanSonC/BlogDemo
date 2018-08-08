Rails.application.routes.draw do
  get "microposts/new"
  get "sessions/new"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :users
  resources :microposts, only: [:create, :destroy, :edit, :update]
end

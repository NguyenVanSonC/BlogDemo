Rails.application.routes.draw do
  get 'comments/new'
  get "microposts/new"
  get "sessions/new"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :microposts, only: [:create, :destroy, :edit, :update]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy, :show]
  resources :relationships, only: [:create, :destroy, :new]
end

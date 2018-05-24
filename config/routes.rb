Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, path: :a, param: :uid
  resources :comments, only: [:create, :edit, :update, :destroy]

  post "/votes" => "votes#create"
  delete "/votes" => "votes#destroy"

  resources :users, path: :u, param: :username, only: [:index, :show]

  devise_for :users

  get "/healthcheck" => "healthcheck#index"
  get "/about" => "about#index"
end

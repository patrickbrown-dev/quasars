Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, path: :a
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :votes, only: [:create]
  resources :users, path: :u, only: [:show]
  get "/u" => "users#current"
  delete "/votes" => "votes#destroy"
  devise_for :users
  get "/healthcheck" => "healthcheck#index"
end

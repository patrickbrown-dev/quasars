Rails.application.routes.draw do
  root to: "articles#index"
  resources :articles, path: :a, param: :uid
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :votes, only: [:create]
  resources :users, path: :u, param: :username, only: [:index, :show]
  delete "/votes" => "votes#destroy"
  devise_for :users
  get "/healthcheck" => "healthcheck#index"
end

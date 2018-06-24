Rails.application.routes.draw do
  root to: 'articles#index'

  resources :articles, path: :a, param: :uid
  resources :comments, only: %i[create edit update destroy]
  resources :reports, only: %i[index create show new] do
    member do
      post :resolve
    end
  end

  post '/votes' => 'votes#create'
  delete '/votes' => 'votes#destroy'

  resources :users, path: :u, param: :username, only: %i[index show]

  devise_for :users

  get '/healthcheck' => 'healthcheck#index'
  get '/about' => 'about#index'
end

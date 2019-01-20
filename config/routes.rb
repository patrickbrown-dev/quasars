Rails.application.routes.draw do
  root to: 'articles#index'

  get '/feed' => 'feed#index'

  resources :articles, path: :a, param: :uid
  get '/a/:uid/(:slug)' => 'articles#show'
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :reports, only: [:index, :create, :show, :new] do
    member do
      post :resolve
    end
  end

  post '/votes' => 'votes#create'
  delete '/votes' => 'votes#destroy'

  resources :users, path: :u, param: :username, only: [:index, :show]

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get '/healthcheck' => 'healthcheck#index'
  get '/about' => 'about#index'
end

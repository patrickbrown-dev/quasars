Rails.application.routes.draw do
  resources :articles
  get "/healthcheck" => "healthcheck#index"
end

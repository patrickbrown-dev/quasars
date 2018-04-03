Rails.application.routes.draw do
  devise_for :users
  get "/healthcheck" => "healthcheck#index"
  root to: "healthcheck#index" # TODO: Remove
end

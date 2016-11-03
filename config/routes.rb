Rails.application.routes.draw do
  devise_for :users
  ActiveAdmin.routes(self)
  resources :animals
  resources :events
  get '/visitors', to: "visitors#index"
  root to: "animals#index"
end

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :animals
  resources :events
  get '/visitors', to: "visitors#index"
  root to: "animals#index"
end

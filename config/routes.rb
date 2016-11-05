Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations'}
  ActiveAdmin.routes(self)
  resources :animals
  resources :events
  authenticated :user do
    root to: "animals#index", as: :authenticated_root
  end
  root to: "visitors#index"
end

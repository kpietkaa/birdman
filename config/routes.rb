Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations'}
  get 'current_user_role', to: "events#current_user_role"
  ActiveAdmin.routes(self)
  resources :animals
  resources :epxes do
    collection do
      put :update_cage
    end
  end
  resources :events do
    member do
      patch :complete
    end
    resources :histories do
      resource :download, only: [:show]
    end
  end
  get "/home", to: 'visitors#index'
  authenticated :user do
    root to: "animals#index", as: :authenticated_root
  end
  root to: "visitors#index"
end

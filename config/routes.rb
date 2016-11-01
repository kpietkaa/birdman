Rails.application.routes.draw do
  resources :animals
  resources :events
  get '/visitors', to: "visitors#index"
end

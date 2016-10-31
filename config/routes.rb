Rails.application.routes.draw do
  resources :animals
  get '/visitors', to: "visitors#index"
end

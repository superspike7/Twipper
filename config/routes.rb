Rails.application.routes.draw do
  root 'static_pages#home'
  resources :twipper, only: :index

  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  get '/sign_up', to: 'users#sign_up'
  post '/registering', to: 'users#registering'
  resources :tasks

end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  namespace :admin, path: "management" do
    resources :users do
      resources :tasks, shallow: true
    end
  end

  get '/new', to: 'users#new'
  post '/create', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :tasks

end

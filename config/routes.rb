Rails.application.routes.draw do
  get 'helps/new'

  root 'static_pages#home'

  # get 'static_pages/help'

  # get '/help', to: 'static_pages#help'

  # get 'static_pages/about'
  get '/about', to: 'static_pages#about'

  # get 'static_pages/contact'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'
  get '/helpup', to: 'helps#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :articles
  resources :microposts, only: [:create, :destroy]
  # root 'application#hello'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :helps
end

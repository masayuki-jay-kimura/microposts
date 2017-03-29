Rails.application.routes.draw do
  get 'static_pages/home'

  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end

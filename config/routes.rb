Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update, :destroy]

  resources :mains, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :ninenn
      get :field
      get :human
      get :data
      get :life
      get :manage
      
      get :group1
    end
  end

  resources :presents, only:[:show, :create, :edit, :update, :destroy] do
    member do
      get :owner
      get :tag1
      get :tag2
      get :tag3
      get :tag4

      get :check
    end
  end

  resources :comments, only: [:create, :edit, :update, :destroy]

  resources :checks, only: [:create, :destroy]
end

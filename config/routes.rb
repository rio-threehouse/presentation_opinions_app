Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:create, :edit, :update, :destroy]

  resources :mains, only: [:show, :create, :edit, :update, :destroy] do
    member do
      get :group1
    end
  end

  resources :presents, only:[:show, :create, :update, :destroy]

end

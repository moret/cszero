Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :cases, only: [:index, :create, :new, :show]
  resources :users, only: [:index, :create, :new, :show]

  root 'root#index'
end

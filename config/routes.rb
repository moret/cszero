Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :cases, only: [:index, :create, :new, :show]
  resources :users, only: [:create, :new, :show]
  resource :report, only: [:show]

  root 'root#index'
end

Rails.application.routes.draw do

  resources :cases
  # get 'cases/new'
  # post 'cases'

  root 'root#index'
end

Rails.application.routes.draw do
  get 'login/index'

  resources :cases
  # get 'cases/new'
  # post 'cases'

  root 'login#index'
end

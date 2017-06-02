Rails.application.routes.draw do

  root :to => 'dashboard#new'
  devise_for :users 
  resources :dashboard, only: [:new] 
end

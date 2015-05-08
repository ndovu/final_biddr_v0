Rails.application.routes.draw do
  
  root 'welcome#index'
  get 'welcome/index'
  
  resources :auctions
  resources :users, only: [:new, :create]
  
end

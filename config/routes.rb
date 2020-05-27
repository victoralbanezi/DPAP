Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :companies, only: [:new, :create, :show] 
  resources :fabrics, only: [ :index, :show ] 

  get 'cart', to: 'fabric_to_carts#show_user_cart'
  resources :fabric_to_carts, only: [:destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

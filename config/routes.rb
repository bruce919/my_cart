Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  resources :products

  resource :cart, only: [:show, :destroy] do
    post :add, path: '/add/:id'
    get :checkout
  end
end

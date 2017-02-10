Rails.application.routes.draw do

  #加入認證
  post 'auth_user' => 'authentication#authenticate_user'

  apipie
  devise_for :users
  root "products#index"
  resources :products,  only: [:index, :show, :new, :create]

  resource :cart, only: [:show, :destroy] do
    post :add, path: '/add/:id'
    get :checkout
  end

  resources :orders, only: [:index, :show, :new, :create] do
	  	member do
	  	delete :cancel
	  end
  end
end
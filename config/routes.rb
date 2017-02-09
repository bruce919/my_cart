Rails.application.routes.draw do

  post 'auth_user' => 'authentication#authenticate_user'
  
  apipie
  devise_for :users
  root "products#index"
  resources :products

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
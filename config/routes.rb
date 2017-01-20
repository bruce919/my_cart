Rails.application.routes.draw do
  root 'products#index'
  resources :products

  resource :cart, only:[:show, :destroy] do
  	post :add, path: 'add/:id'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :companies do
  	member do
  		patch 'addbrand'
  	end
  end
  resources :regions
  resources :stores
  resources :brands do
  	resources :items
  end
end

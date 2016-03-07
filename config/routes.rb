Rails.application.routes.draw do

	root "main#welcome"
	devise_for :users

	resources :products
	resources :galleries
	resources :pictures

	match 'admin', to: 'main#admin', via: :get
  
  
end

Rails.application.routes.draw do

	root "main#welcome"
	#get '/:locale' => 'dashboard#index'
	#match '', to: redirect("/#{I18n.locale}"), via: :get
	#scope "(:locale)", locale: /en|bi|fr/ do
	scope "(/:Locale)" do
		#root "main#welcome"
		devise_for :users

		resources :news, only: [:create]
		resources :order_lines, only: [:create, :update, :destroy]
		
		namespace :shop do
		  resources :products, only: [:index, :show]
		end
		namespace :showroom do
			resources :products, only: [:index]
		end		

		#resources :carts, only: [:show]
		match '/cart', to: 'carts#show', via: :get, as: :cart
		#resources :orders, only: [:update, :destroy] do
		#	collection do
		#		patch 'pass'
		#	end
		#end
		#
		#resources :products do
		#	collection do
		#		get 'browse'
		#	end
		#end

	end
end
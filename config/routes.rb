Rails.application.routes.draw do

	match '', to: redirect("/#{I18n.locale}"), via: :get
	scope "(:locale)", locale: /en|bi|fr/ do
		root "main#welcome"
		devise_for :users
		resources :news, only: [:create]
		#resources :carts, only: [:show]
		match '/cart', to: 'carts#show', via: :get, as: :cart
		resources :orders, only: [:update, :destroy] do
			collection do
				patch 'pass'
			end
		end
		resources :order_lines, only: [:create, :update, :destroy]
		resources :products do
			collection do
				get 'browse'
			end
		end

	end
end
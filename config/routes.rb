Rails.application.routes.draw do

	match '', to: redirect("/#{I18n.locale}"), via: :get
	scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
		root to: "main#welcome"
		devise_for :users
		resources :news, only: [:create]
		resources :order_lines, only: [:create, :update, :destroy]
		resources :orders
		match '/terms', to: 'main#terms', via: :get, as: :terms
		match '/back', to: 'main#redirect_to_back', via: :get, as: :back
		namespace :shop do
		  resources :products, only: [:index, :show]
		  resources :fabrics, only: [:index, :show]
		  match '/cart', to: 'carts#show', via: :get, as: :cart_show
		  match 'update_product_price', to: 'products#update_price', via: :get, as: :update_product_price
		  match 'update_final_price', to: 'carts#update_price', via: :get, as: :update_final_price
		  match '/workshop', to: 'workshop#show', via: :get, as: :workshop
		end
		namespace :showroom do
			resources :products, only: [:index]
		end
	end

	mount ForestLiana::Engine => '/forest'
	namespace :forest do
	  post '/actions/do_it' => 'products#do_it'
	end

end
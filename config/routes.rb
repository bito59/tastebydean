Rails.application.routes.draw do

  mount ForestLiana::Engine => '/forest'
	root "main#welcome"
	#match '', to: redirect("/#{I18n.locale}"), via: :get
	#scope "(:locale)", locale: /en|bi|fr/ do
	scope "(/:Locale)" do
		devise_for :users
		resources :news, only: [:create]
		resources :order_lines, only: [:create, :update, :destroy]
		resources :orders#, only: [:show, :edit]
		match '/terms', to: 'main#terms', via: :get, as: :terms
		match '/back', to: 'main#redirect_to_back', via: :get, as: :back
		
		namespace :admin do
		  resources :products do
		  	resources :pictures, only: [:create, :destroy]
		  	resources :main_pictures, only: [:create, :destroy]
		  end
		end

		namespace :forest do
		  post '/actions/do_it' => 'products#do_it'
		end

		namespace :shop do
		  resources :products, only: [:index, :show]
		  resources :fabrics, only: [:index, :show]
		  #resources :orders, only: [:edit, :new, :show]
		  #resources :order_lines, only: [:destroy]
		  match '/cart', to: 'carts#show', via: :get, as: :cart_show
		  match 'update_price', to: 'products#update_price', via: :get, as: :update_price
		  match '/workshop', to: 'workshop#show', via: :get, as: :workshop
		end
		namespace :showroom do
			resources :products, only: [:index]
		end
	end
end
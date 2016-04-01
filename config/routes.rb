Rails.application.routes.draw do
	scope "(:locale)", locale: /en|bi|fr/ do
		root "main#welcome"
		devise_for :users
		
		match 'users/:id', to: 'users#destroy', via: :delete, as: :destroy_user
		match '/users/:id', to: 'users#show', via: :get, as: :user
		get '/users/sign_out', to: 'devise/sessions#destroy'  


		resources :products
		resources :galleries
		resources :pictures
		resources :users
		resources :posters
		scope "/admin" do
			match '', to: 'admin#index', via: :get, as: :admin
			match '/products', to: 'admin#admin_products', via: :get, as: :admin_products
			match '/users', to: 'admin#admin_users', via: :get, as: :admin_users
			match '/posters', to: 'admin#admin_posters', via: :get, as: :admin_posters
		end
	end

end

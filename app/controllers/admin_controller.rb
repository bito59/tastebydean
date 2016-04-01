class AdminController < ApplicationController
	#skip_before_filter :authenticate_user!

	def index
	end

	def admin_products
		@malemodels = Product.all.where("kind = ?", "male")
		@femalemodels = Product.all.where("kind = ?", "female")
		@materials = Product.all.where(kind: "material").order("created_at DESC")
		@grid = ProductsGrid.new(params[:products_grid]) do |scope|
			scope.page(params[:page]) # See pagination section
	    end
		#render 'admin/products/index_products'
		render 'admin/index'
	end

	def admin_users
		@users = User.all
		render 'admin/users/index_users'
	end

	def admin_posters
		@posters = Poster.all
		render 'admin/posters/index_posters'
	end

end

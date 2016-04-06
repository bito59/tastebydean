class AdminController < ApplicationController
	#skip_before_filter :authenticate_user!

	def index
		render 'admin/index_admin'
	end

	def admin_products
		@product = Product.new
		@filterrific = initialize_filterrific(
		    Product,
		    params[:filterrific]
		  ) or return
		  @products = @filterrific.find.page(params[:page]).paginate(page: params[:page], per_page: 10)

		  respond_to do |format|
		    format.html { render 'admin/products/index_products' }
		    format.js
		  end
	end

	def admin_users
		@users = User.all
		render 'admin/users/index_users'
	end

	def admin_posters
		@posters = Poster.unscoped.all
		render 'admin/posters/index_posters'
	end

end

class AdminController < ApplicationController
	#skip_before_filter :authenticate_user!

	def admin_products
		@malemodels = Product.all.where("kind = ?", "model-male")
		@femalemodels = Product.all.where("kind = ?", "model-female")
		@materials = Product.all.where(kind: "material").order("created_at DESC")
		render 'admin/products/index_products'
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

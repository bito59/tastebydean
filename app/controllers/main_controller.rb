class MainController < ApplicationController
	skip_before_filter :authenticate_user!
	#, only: :welcome

	def welcome
		@products = Product.all
	end

	def admin
		@models = Product.all.where("kind = ? or kind = ?", "model-female", "model-male")
		@materials = Product.all.where(kind: "material").order("created_at DESC")
	end

end

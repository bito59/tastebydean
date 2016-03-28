class MainController < ApplicationController
	skip_before_filter :authenticate_user!
	#, only: :welcome

	def welcome
		#@products = Product.all
	end

end

module Shop
	class CartsController < ApplicationController
		include ApplicationHelper

		def show
			@order = current_order
			@order_lines = current_order.order_lines
		end
	  
	end
end

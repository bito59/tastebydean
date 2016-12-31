class CartsController < ApplicationController
	include ApplicationHelper

	def show
		@order = current_order
		@order_lines = current_order.order_lines
		@user = current_user
	end
  
end

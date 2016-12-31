class OrdersController < ApplicationController
	include ApplicationHelper

	def pass
		@order = current_order
		if @order.update(order_params)
			@order.change_order_status('passed')
			session.delete :order_id
			#OrderMailer.confirm_order(User.first, @order).deliver
			flash_message('confirm', 'The order ' + @order.serial + ' has been created !')
			redirect_to root_path
		else
			flash_message('alert', 'There is a problem with your order...')
			redirect_to cart_path
		end
  	end

private

	def order_params
		params.require(:order).permit( :delivery_method, :payment_method, :user_id,
			:name, :surname, :address, :zipcode, :city, :country, :phone)
	end

end
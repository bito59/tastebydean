class OrdersController < ApplicationController
	include ApplicationHelper

	def update
		@order = current_order
		#puts '@order : ' + @order.inspect
		if @order.update(order_params)
			if order_params[:accept_conditions] == 'false'
				flash_message('notice', t('flash_messages.pls_accept_conditions'))
				redirect_to shop_cart_show_path
			elsif order_params[:delivery_method] == 'delivery' && order_params.values.any?(&:blank?)
				flash_message('notice', t('flash_messages.pls_check_adress'))
				redirect_to shop_cart_show_path
			else
				@order.change_order_status('passed')
				session.delete :order_id
				flash_message('success', t('flash_messages.order_passed', serial: @order.serial))
				redirect_to root_path
			end
		else
			flash_message('alert', t('flash_messages.order_cant_pass'))
			redirect_to shop_cart_show_path
		end
  	end


	private

	def order_params
		params.require(:order).permit( :delivery_method, :payment_method, :user_id,
			:name, :surname, :address, :zipcode, :city, :country, :phone, :accept_conditions)
	end

end
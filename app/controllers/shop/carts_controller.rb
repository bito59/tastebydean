module Shop
	class CartsController < ApplicationController
		include ApplicationHelper
		before_action :find_ol, only: [:destroy]

		def show
			@order = current_order
			#@new_order = Order.new()
			respond_to do |format|
				if @order.order_lines.count > 0
					format.html { render 'shop/cart/show' }				
				else
					flash_message('notice', t('flash_messages.empty_cart'))
					format.html { redirect_to :back }
				end
			end
		end

		def destroy
			@order = @ol.order
			respond_to do |format|
				if @order.order_lines.count == 1 && @order.destroy
					flash_message('success', t('flash_messages.ol_deleted'))
					format.js { redirect_to root_path }
				elsif @ol.destroy
					@order.reload
					flash_message('success', t('flash_messages.ol_deleted'))
					format.js { render 'shop/cart/ol_destroy.js.erb' }				
				else
					flash_message('alert', t('flash_messages.cant_delete_ol'))
					format.js { redirect_to cart_path }
				end
			end
		end

		private
   
		def find_ol
			@ol = OrderLine.find(params[:id])
			#puts 'Product was loaded : ' + @product.inspect
		end

	end
end

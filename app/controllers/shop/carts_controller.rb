module Shop
	class CartsController < ApplicationController
		include ApplicationHelper
		before_action :find_ol, only: [:destroy]

		def show
			@order = current_order
			@bck_size = 'bck-img-tb'
			@bck_img = 'img-login'
			respond_to do |format|
				if @order.order_lines.count > 0
					format.html { render 'shop/cart/show' }				
				else
					flash_message('notice', t('flash_messages.empty_cart'))
					format.html { redirect_to :back || root_path }
				end
			end
		end

		def update_price
			@order = current_order
			puts @order.inspect
			respond_to do |format|
				if @order.update_attributes(delivery_method: params[:delivery_method])
					@order = current_order
					format.js { render 'shop/cart/update_cart.js.erb' }
				else
					flash_message('notice', t('flash_messages.cannot_update_price'))
					format.js { render 'shop/cart/update_cart.js.erb' }
				end
			end
			puts @order.inspect
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

		def cart_params
			params.require(:cart).permit(:order_id, :delivery_method)
		end

	end
end

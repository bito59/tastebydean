class OrderLinesController < ApplicationController
  include ApplicationHelper
  before_action :find_product, only: [:create]

  def create
  	@order = current_order
    @order_line = @order.order_lines.new(order_line_params)
    respond_to do |format|
      if @order.save
        @order.save
        session[:order_id] = @order.id
        if params[:order_line][:quantity].to_i > 1
          flash_message('success', t('.items_added'))
        else
          flash_message('success', t('.item_added'))
        end
        format.html { redirect_to shop_product_path(@product) }
      else
        flash_message('error', t('.item_not_added'))
      end
    end
  end

  def update
  	@order = current_order
    @order_line = @order.order_lines.find(params[:id])
    @order_line.update_attributes(order_line_params)
    @order_lines = @order.order_lines
  end

  def destroy
    @order = current_order
    @order_line = OrderLine.find(params[:id])
    respond_to do |format|
      if @order_line.destroy
        @order.save
        if @order.order_lines.any?
          flash_message('success', t('.ol_removed'))
          format.js { render 'order_lines/destroy.js.erb' }
        else
          format.js { render js: "window.location = '#{root_path}'" }
        end
      end
    end
  end

  private

  def order_line_params
    params.require(:order_line).permit(:quantity, :size, :sep_fabric, :product_id, :fabric_id)
  end

  def find_product
    @product = Product.friendly.find(order_line_params[:product_id])
  end

end

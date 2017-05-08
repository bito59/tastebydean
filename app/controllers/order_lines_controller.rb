class OrderLinesController < ApplicationController
  include ApplicationHelper
  skip_before_action :auth_user, only: [:create]
  before_action :find_product, only: [:create]
  before_action :set_order_line, only: [:show, :edit, :update, :destroy]

  def create
    #save the current order instance stored in the session
  	@order = current_order
    @order.save
    @order_line = @order.order_lines.new(order_line_params)
    session[:order_id] = @order.id
    #set prices
    if params[:order_line][:sep_fabric] == 'true'
      @order_line.fabric_price = 0
    else
      @order_line.fabric_price = find_fabric_price(@product.id, @order_line.fabric_id, 
        @order_line.std_size)
    end
    @order_line.confection_price = @product.confection_price
    #set the session_id to @order.id
    respond_to do |format|
      if @order_line.save
        if params[:order_line][:quantity].to_i > 1
          flash_message('success', t('.items_added'))
        else
          flash_message('success', t('.item_added'))
        end
        format.html { redirect_to shop_product_path(@product) }
      else
        flash_message('alert', t('.item_not_added'))
        format.html { render :new }
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

  # Use callbacks to share common setup or constraints between actions.
  def set_order_line
    @order_line = OrderLine.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_line_params
    #params.fetch(:order_line, {}).permit(:order_id, :product_id, :fabric_id, :std_size, :sep_fabric, :quantity)
    params.require(:order_line).permit(:order_id, :product_id, :fabric_id, :std_size, :sep_fabric, :quantity)
  end

  def find_product
    @product = Product.friendly.find(order_line_params[:product_id])
  end

end

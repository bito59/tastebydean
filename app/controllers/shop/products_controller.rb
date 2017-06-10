module Shop
  class ProductsController < ApplicationController
    include ApplicationHelper

  	skip_before_action :auth_user, only: [:index, :show, :update_price]
  	before_action :find_product, only: [:show, :update_price]
    before_action :load_products, only: [:index]

  	def index
      define_area
  		respond_to do |format|
  		    format.html { render 'shop/index' }
  		end
  	end

  	def show
      if params[:selected_fabric_id]
        fabric_price = find_fabric_price(@product.id, params[:selected_fabric_id], nil)
        @order_line = current_order.order_lines.new(
          product_id: @product.id,
          sep_fabric: false,
          fabric_id: params[:selected_fabric_id],
          std_size: params[:std_size],
          confection_price: @product.confection_price,
          fabric_price: fabric_price,
          quantity: 1,
          price_unit: '€',
        )
      else
        @order_line = current_order.order_lines.new(
          product_id: @product.id,
          confection_price: @product.confection_price,
        )
      end
      @total_price = @order_line.calc_price
      @sizes = @product.load_sizes
      @pictures = @product.product_pictures.active
  		respond_to do |format|
  			format.html { render 'shop/show/show' }
  		end
  	end

    def update_price
      qty = if params[:qty] == nil then 1 else params[:qty].to_f end
      if params[:sep_fabric] == 'true' || params[:fabric_id].empty?
        fabric_price = 0
      else
        fabric_price = find_fabric_price(@product.id, params[:fabric_id], params[:std_size])
      end
      orderline = OrderLine.new(
        confection_price: @product.confection_price, fabric_price: fabric_price, 
        quantity: qty)
      puts orderline.inspect
      @total_price = orderline.calc_price
      respond_to do |format|
        format.js { render 'shop/show/update_product_price.js.erb' }
      end
    end

    private
   
      def find_product
        @product = Product.friendly.find(params[:id]).decorate
        #puts 'Product was loaded : ' + @product.inspect
      end

      def product_params
        params.require(:product).permit(
          :title, :description, :activated, :kind, :family, :customer, :event, 
          :price, :price_unit, :measure, :measure_unit,
          :product_pictures_attributes,
        )
      end
        
      def load_products
        @products = Product.with_kind(params[:kind]).on_site
        if params[:customer]
          if params[:customer] == 'man' || params[:customer] == 'woman'
            @products = @products.with_customer(params[:customer], 'adult')
          elsif params[:customer] == 'boy' || params[:customer] == 'girl'
            @products = @products.with_customer(params[:customer], 'child')
          end
        end
        @products.decorate
        puts @products.inspect
      end
  end
end

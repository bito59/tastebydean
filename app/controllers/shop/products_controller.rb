module Shop
  class ProductsController < ApplicationController
    include ApplicationHelper

  	skip_before_action :auth_user, only: [:index, :show]
  	before_action :find_product, only: [:show]
    before_action :load_products, only: [:index]

  	def index
      define_area
  		respond_to do |format|
  		    format.html { render 'shop/index' }
  		end
  	end

  	def show
      puts 'current order is : ' + current_order.inspect
      if params[:selected_fabric_id]
        unless params[:std_size]
          params[:std_size] = true
        end
        fabric_family_id = Fabric.friendly.find(params[:selected_fabric_id]).fabric_family.id
        prices = @product.product_family.fabric_prices.where(fabric_family_id: fabric_family_id).first
        if params[:std_size] = true
          fabric_price = prices.price_std
        else
          fabric_price = prices.price_big
        end
        puts 'fabric price calculated is : ' + fabric_price.to_s
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
      @total_price = @order_line.total_price
      puts 'total price is : ' + @total_price.to_s
      @sizes = @product.load_sizes
      @pictures = @product.product_pictures.active
  		respond_to do |format|
  			format.html { render 'shop/show' }
  		end
  	end

    def update_price
      product = Product.find(params[:product_id])
      product_family = product.product_family
      if params[:qty]
        quantity = params[:qty].to_f
      else
        quantity = 1
      end
      if params[:sep_fabric] == 'true' || params[:fabric_id].empty?
        f_price = 0
      else
        fabric_family = Fabric.find(params[:fabric_id]).fabric_family
        fabric_price = FabricPrice.where(product_family_id: product_family.id, 
          fabric_family_id: fabric_family.id).first
        if params[:std_size] == 'true'
          f_price = fabric_price.price_std
        elsif params[:std_size] == 'false'
          f_price = fabric_price.price_big
        end
      end
      puts 'fabric_price is : ' + f_price.to_s
      @total_price = (product.confection_price + f_price) * quantity
      puts 'total_price is : ' + @total_price.to_s
      respond_to do |format|
        format.js { render 'shop/update_price.js.erb' }
      end
    end

    private
   
      def find_product
        @product = Product.friendly.find(params[:id]).decorate
        puts 'Product was loaded : ' + @product.inspect
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
        if params[:customer] == 'child'
          @products = @products.child
        elsif params[:customer]
          @products = @products.with_customer(params[:customer])
        end
        @products.decorate
        puts @products.inspect
      end
  end
end

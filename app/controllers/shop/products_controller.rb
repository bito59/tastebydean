module Shop
  class ProductsController < ApplicationController
    include ApplicationHelper

  	skip_before_action :auth_user, only: [:index, :show]
  	before_action :find_product, only: [:show]
    before_action :load_products, only: [:index]

  	def index
      define_area
      #@query= params
      #puts 'query was : ' + params.inspect
  		respond_to do |format|
  		    format.html { render 'shop/index' }
  		end
  	end

  	def show
      if params[:selected_fabric_id]
        unless params[:std_size]
          params[:std_size] = true
        end
        @order_line = current_order.order_lines.new(
          std_size: params[:std_size],
          fabric_id: params[:selected_fabric_id],
          sep_fabric: false
        ) 
      else
        @order_line = current_order.order_lines.new
      end
      @sizes = @product.find_sizes
      @pictures = @product.product_pictures.active
  		respond_to do |format|
  			format.html { render 'shop/show' }
  		end
  	end

    private
   
      def find_product
        @product = Product.friendly.find(params[:id]).decorate
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

module Shop
  class ProductsController < ApplicationController
    include ApplicationHelper

  	skip_before_action :auth_user, only: [:index, :show]
  	before_action :find_product, only: [:show, :edit, :update, :destroy]

  #-------------- Actions for customers --------------------------------------------------------------------

  	def index
      @path = params[:kind].to_s
  		load_products
  		respond_to do |format|
  		    format.html { render 'shop/index' }
  		end
  	end

  	def show
  		#@main_picture = @product.product_pictures.active.main.random.first
  		#@pictures = @product.product_pictures.active.where.not(id: @main_picture.id)
      @order_line = current_order.order_lines.new 
  		respond_to do |format|
  			format.html { render 'shop/show.html.haml' }
  		end
  	end



  #-------------- Methods --------------------------------------------------------------------

    private
   
      def find_product
        @product = Product.friendly.find(params[:id])
      end

      def product_params
        params.require(:product).permit(
          :title, :description, :activated, :kind, :family, :customer, :event, 
          :price, :price_unit, :measure, :measure_unit,
          :product_pictures_attributes,
          :images,
          )
      end
        
      def load_products
        @products = Product.with_kind(params[:kind]).actives
        #.with_picture
        if params[:customer] == 'child'
          @products = @products.child
        elsif params[:customer]
          @products = @products.with_customer(params[:customer])
        end
        @products
      end

      def filter_products
        @filterrific = initialize_filterrific(
          Product,
          params[:filterrific],
          select_options: {
            sorted_by: Product.options_for_sorted_by,
            with_kind: Product::KINDS,
            with_customer: Product::CUSTOMERS,
            with_family: Product::FAMILIES,
            with_event: Product::EVENTS,
            activated: [true, false]
          }
        ) or return
        @products = Product.filterrific_find(@filterrific).page(params[:page]).paginate(page: params[:page], per_page: 10)
      end

  end
end

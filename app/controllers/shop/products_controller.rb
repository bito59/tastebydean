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
        fabric_price = find_fabric_price(@result.id, params[:selected_fabric_id], nil)
        @orderline = current_order.order_lines.new(
          product_id: @result.id,
          sep_fabric: false,
          fabric_id: params[:selected_fabric_id],
          std_size: params[:std_size],
          confection_price: @result.confection_price,
          fabric_price: fabric_price,
          quantity: 1,
          price_unit_id: 1
        ).decorate
      else
        @orderline = current_order.order_lines.new(
          product_id: @result.id,
          confection_price: @result.confection_price,
          price_unit_id: 1
        ).decorate
      end
      @orderline.calc_price
      @sizes = @result.load_sizes
      @pictures = @result.product_pictures.active
  		respond_to do |format|
  			format.html { render 'shop/show/show' }
  		end
  	end

    def update_price
      qty = if params[:qty] == nil then 1 else params[:qty].to_f end
      if params[:sep_fabric] == 'true' || params[:fabric_id].empty?
        fabric_price = 0
      else
        fabric_price = find_fabric_price(@result.id, params[:fabric_id], params[:std_size])
      end
      @orderline = OrderLine.new(
        confection_price: @result.confection_price, 
        fabric_price: fabric_price, 
        quantity: qty,
        price_unit_id: @result.price_unit.id
      ).decorate
      @orderline.calc_price
      respond_to do |format|
        format.js { render 'shop/show/update_product_price.js.erb' }
      end
    end

    private
   
      def find_product
        @result = Product.friendly.find(params[:id]).decorate
      end

      def product_params
        params.require(:product).permit(
          :title, :description, :activated, :kind, :family, :customer, :event, 
          :price, :price_unit, :measure, :measure_unit,
          :product_pictures_attributes,
        )
      end
        
      def load_products
        @results = Product.with_kind(params[:kind]).on_site
        if params[:customer]
          if params[:customer] == 'man' || params[:customer] == 'woman'
            @results = @results.with_customer(params[:customer], 'adult')
          elsif params[:customer] == 'boy' || params[:customer] == 'girl'
            @results = @results.with_customer(params[:customer], 'child')
          end
        end
        @results.decorate
        puts @results.inspect
      end
  end
end

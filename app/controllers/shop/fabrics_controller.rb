module Shop
  class FabricsController < ApplicationController
    include ApplicationHelper

  	skip_before_action :auth_user, only: [:index, :show]
  	before_action :find_fabric, only: [:show]
    before_action :load_fabrics, only: [:index]

  	def index
      define_area
  		respond_to do |format|
  		    format.html { render 'shop/index' }
  		end
  	end

  	def show
      @order_line = current_order.order_lines.new
      if params[:selected_product_id]
        product_family_id = Product.friendly.find(params[:selected_product_id]).product_family.id
        @price = @product.fabric_family.fabric_prices.where(product_family_id: product_family_id).first
      end
  		respond_to do |format|
  			format.html { render 'shop/show.html.haml' }
  		end
  	end

    private
   
      def find_fabric
        @product = Fabric.friendly.find(params[:id]).decorate
      end

      def fabric_params
        params.require(:fabric).permit(
          :title, :description, :activated, :kind, :family, :customer, :event, 
          :price, :price_unit, :measure, :measure_unit,
          :fabric_pictures_attributes,
        )
      end
        
      def load_fabrics
        @products = Fabric.on_site
        unless params[:family].nil?
          @products = @products.with_family(params[:family])
        end
        puts @fabrics.inspect
      end
  end
end

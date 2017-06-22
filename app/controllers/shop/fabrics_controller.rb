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
      if params[:selected_product_id]
        product_family_id = Product.friendly.find(params[:selected_product_id]).product_family.id
        price = @result.fabric_family.fabric_prices.where(product_family_id: product_family_id).first
      end
      @orderline = current_order.order_lines.new(
        product_id: params[:selected_product_id],
        fabric_price: price
        ).decorate
      @pictures = @result.fabric_pictures.active.view
  		respond_to do |format|
  			format.html { render 'shop/show/show' }
  		end
  	end

    private
  
      def fabric_params
        params.require(:fabric).permit(
          :title, :description, :activated, :kind, :family, :customer, :event, 
          :price, :price_unit, :measure, :measure_unit,
          :fabric_pictures_attributes,
        )
      end

      def find_fabric
        @result = Fabric.friendly.find(params[:id]).decorate
      end
        
      def load_fabrics
        @results = Fabric.on_site
        unless params[:family].nil?
          @results = @results.with_fabric_family(params[:family])
        end
      end
  end
end

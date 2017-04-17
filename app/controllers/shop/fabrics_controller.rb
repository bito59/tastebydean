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
        @products = Fabric.with_kind(params[:kind]).on_site
        unless params[:family].nil?
          @products = @products.with_family(params[:family])
        end
        puts @fabrics.inspect
      end
  end
end

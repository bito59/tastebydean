module Showroom
  class ProductsController < ApplicationController
    include ApplicationHelper
    skip_before_action :auth_user, only: [:index]

    def index
      load_products
      respond_to do |format|
          format.html { render 'showroom/index' }
      end
    end

    private
        
    def load_products
      @products = Product.with_kind(params[:kind]).actives.with_picture
    end
  end
end

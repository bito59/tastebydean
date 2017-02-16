module Admin
  class ProductsController < ApplicationController
    include ApplicationHelper
    before_action :find_product, only: [:show, :edit, :update, :destroy]
    skip_before_action :auth_user

    def index
      @products = Product.all
      respond_to do |format|
        format.html { render 'admin/products/index' }
      end
    end

    def show
      @product_pictures = @product.product_pictures.all
      respond_to do |format|
        format.html { render 'admin/products/show' }
      end
    end

    def edit
      respond_to do |format|
        format.html { render 'admin/products/edit' }
      end
    end

    def new
      @product = Product.new
      @product_picture = @product.product_pictures.build
    end

    def create
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
        else
          format.html { render action: 'new' }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update_attributes(product_params)
          format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully updated.' }
        else
          format.html { render action: 'edit' }
        end
      end
    end

    private

    def find_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :title, :description, :activated, :kind, :family, :customer, :event, 
        :price, :price_unit, :measure, :measure_unit, {pictures: []})
    end
  end
end

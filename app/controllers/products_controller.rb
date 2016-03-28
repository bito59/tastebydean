class ProductsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  include ProductsHelper

  def index
    products = Product.joins(:pictures).group("products.id").where(activated: true).having("count(pictures.id) > ?",0)
    if params[:kind] == "material"
      @products = products.filter(params.slice(:kind, :family, :customer))     
    else
      @products = products.where("kind = ? or kind = ?", "model-female", "model-male")
    end
    respond_to do |format|
      if params[:display] == "large"
        format.js { render 'display_large.js.erb' }
      elsif params[:display] == "small"
        format.js { render 'display_small.js.erb' }
      else
        format.html { render }
      end
    end
  end

  def filter
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.js { render 'admin/products/new.js.erb' }
    end
  end

  def show
    respond_to do |format|
      format.js { render 'admin/products/show.js.erb' }
    end
  end

  def edit
    respond_to do |format|
      format.js   { render 'admin/products/edit.js.erb' }
    end
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        @gallery = @product.build_gallery()
        @gallery.save
        format.js   { render 'admin/products/show.js.erb' }
      end
    end
  end

  def update
    @product.slug = nil
    respond_to do |format|
      if @product.update(product_params)
        format.js   { render 'admin/products/update.js.erb' }           
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.js   { render 'admin/products/destroy.js.erb' }
      end
    end
  end

  private
    def find_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :activated, :kind, :family, :customer, :event, :price, :price_unit, :measure, :measure_unit, :image)
    end

end

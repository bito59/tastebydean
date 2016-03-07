class ProductsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  include ProductsHelper

  def index
    products = Product.joins(:pictures).group("products.id").where(activated: true).having("count(pictures.id) > ?",0)
    @products = products.filter(params.slice(:kind, :family, :customer))
  end

  def filter
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.js { render 'new.js.erb' }
    end
  end

  def show
    respond_to do |format|
      format.js { render 'show.js.erb' }
    end
  end

  def edit
    respond_to do |format|
      format.js   { render 'edit.js.erb' }
    end
  end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        @gallery = @product.build_gallery()
        @gallery.save
        #format.html { redirect_to admin_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
        format.js   { render 'show.js.erb' }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
        format.js   { }
      end
    end
  end

  def update
    @product.slug = nil
    respond_to do |format|
      if @product.update(product_params)
        #format.html { }
        format.json { render :show, status: :ok, location: @product }
        format.js   { render 'products/update.js.erb' }           
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      #format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render 'destroy.js.erb' }
    end
  end

  private
    def find_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :activated, :kind, :family, :customer, :new_product, :price, :price_unit, :measure, :measure_unit, :image)
    end

end

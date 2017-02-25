class ProductsController < ApplicationController
  include ApplicationHelper
  before_action :find_product, only: [:update, :destroy]

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        params[:product_pictures]['image'].each do |a|
          @product_picture = @product.product_pictures.create!(image: a)
        end
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update_attributes(product_params)
        params[:product_pictures]['image'].each do |a|
          @product_picture = @product.product_pictures.create!(image: a)
        end
        format.html { redirect_to admin_product_path(@product), notice: 'Product was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        @product.product_pictures.try(:remove!) # delete picture from S3
        format.json render status: 200, json: {
          success: "Successfully destroyed..."
        }.to_json
      else
        format.json render status: 400, json: {
          error: "Didnt destroy !"
        }.to_json
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
      :price, :price_unit, :measure, :measure_unit,
      product_pictures_attributes: [:id, :product_id, :image])
  end
end


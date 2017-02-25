module Admin
  class MainPicturesController < ApplicationController
    before_action :set_product
    skip_before_action :auth_user

    def create
      if @product.save
        redirect_to admin_product_path(@product), notice: 'Picture(s) was successfully created.' 
      else
        redirect_to :back
      end
    end

    def destroy
      remove_picture
      if @product.save
        redirect_to admin_product_path(@product), notice: 'Picture(s) was successfully removed.' 
      else
        redirect_to :back
      end
    end

    private

    def set_product
      @product = Product.find(params[:product_id])
    end

    def remove_picture
      @product.main_pict[0].delete
      @product.main_pict[0].try(:remove!) # delete picture from S3
    end

    def pictures_params
      params.require(:product).permit({main_pict: []}) # allow nested params as array
    end
  end
end
module Admin
  class PicturesController < ApplicationController
    before_action :set_product
    skip_before_action :auth_user

    def create
      add_more_pictures(pictures_params[:pictures])
      if @product.save
        redirect_to admin_product_path(@product), notice: 'Picture(s) was successfully created.' 
      else
        redirect_to :back
      end
    end

    def destroy
      remove_picture_at_index(params[:id].to_i)
      if @product.save
        #puts 'product was saved after image delete'
        redirect_to admin_product_path(@product), notice: 'Picture(s) was successfully updated.' 
      else
        redirect_to :back
      end
    end

    private

    def set_product
      @product = Product.find(params[:product_id])
      #@product = Product.friendly.find(params[:id])
    end

    def add_more_pictures(new_pictures)
      pictures = @product.pictures # copy the old pictures 
      pictures += new_pictures # concat old pictures with new ones
      @product.pictures = pictures # assign back
    end

    def remove_picture_at_index(index)
      remain_pictures = @product.pictures # copy the array
      deleted_picture = remain_pictures.delete_at(index) # delete the target picture
      deleted_picture.try(:remove!) # delete picture from S3
      @product.pictures = remain_pictures # re-assign back
      @product.remove_pictures! if remain_pictures.empty?
    end

    def pictures_params
      params.require(:product).permit({pictures: []}) # allow nested params as array
    end
  end
end
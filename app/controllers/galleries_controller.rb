class GalleriesController < ApplicationController
	skip_before_filter :authenticate_user!
	before_action :find_gallery, only: [:show, :edit, :update]

	def show
		@product = Product.find_by(id: @gallery.product_id)
		@pictures = @gallery.pictures.all
		#@pictures = Picture.where(gallery_id: @gallery.product_id)
		@new_picture = @gallery.pictures.build
		#@picture = Picture.new(gallery_id: @gallery.id)
	end

	def edit

	end

	def update

	end

	private

    def find_gallery
      	@gallery = Gallery.find_by(product_id: params[:id])
    end

	def gallery_params
	    params.require(:gallery).permit()
	end

end

class ProductPicture < ApplicationRecord
	#validates_processing_of :image
	validate :image_size_validation

	mount_uploader :picture, PictureUploader
	belongs_to :product

	private

	def image_size_validation
		errors[:image] << "should be less than 10MB" if image.size > 10.megabytes
	end

end

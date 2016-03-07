class Picture < ActiveRecord::Base

	belongs_to :library

	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/product_missing.jpg"
	validates_attachment_presence :image
	#validates_attachment_file_name :image, :matches => [/jpe?g\z/, /gif\z/, /png\z/]
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"]
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

class Picture < ActiveRecord::Base

	belongs_to :library
	has_one :product, through: :library

	has_attached_file :image, styles: { large: "768x1152", big: "400x600>", medium: "200x300" ,thumb: "150x225>" }, default_url: "/images/products/:style/product_missing.jpg"
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/png"]
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end

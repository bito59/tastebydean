class Poster < ActiveRecord::Base

	validates_presence_of :title, :text

	has_attached_file :image, styles: { large: "600x600"}, default_url: "/images/posters/poster_missing.jpg"
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/png"]
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	validates :image, dimensions: { width: 600, height: 600 }

end

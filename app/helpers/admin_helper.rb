module AdminHelper

	def count_pictures(product)
    	nb_picture = product.pictures.count
    	'Gallery (' + nb_picture.to_s + ')'
  	end

end

module ProductsHelper

	def check_status(products)
		products.each do |product|
			if product.activated == false
				products.remove(product)
			end
		end
	end

end

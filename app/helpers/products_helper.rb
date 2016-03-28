module ProductsHelper

	def check_status(products)
		products.each do |product|
			if product.activated == false
				products.remove(product)
			end
		end
	end

	def show_event(product)
		if product.event == "new"
			image = "icons/new.png"
		elsif product.event == "discount"
			image = "icons/new.png"
		end
	end
end

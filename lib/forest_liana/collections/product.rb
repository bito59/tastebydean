class Forest::Product
	include ForestLiana::Collection

	#collection :products
	#field :prices, type: 'String' do
	#	if object.price > 1
	#		"#{object.price.to_s} #{object.price_unit}s"
	#	else
	#		"#{object.price.to_s} #{object.price_unit}"
	#	end
	#end
	field :main_pict, type: 'String' do
		unless object.product_pictures.main.empty?
			data = object.product_pictures.main.as_json
			puts  JSON.pretty_generate data
			data = data[0]['image'].thumb.url
			puts data
			data
		end	
	end
	field :nb_pict, type: 'String' do
		object.product_pictures.count
	end
	field :online, type: 'Boolean' do
		if object.on_site? == true
			true
		else
			false
		end
	end

	segment 'Creations on site' do
		{ id: Product.on_site.with_kind('creation').map(&:id) }
	end
	segment 'Models on site' do
		{ id: Product.on_site.with_kind('model').map(&:id) }
	end
	segment 'Accessories on site' do
		{ id: Product.on_site.with_kind('accessory').map(&:id) }
	end

end
class Forest::Product
	include ForestLiana::Collection

	collection :products
	field :prices, type: 'String' do
		"#{object.price.to_s} #{object.price_unit}"
	end
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
		object.product_pictures.active.count
	end
end
#{}"#{object.product_pictures.first.image.url.to_s}"
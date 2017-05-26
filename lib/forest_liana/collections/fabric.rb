class Forest::Fabric
	include ForestLiana::Collection

	collection :fabrics
	#field :prices, type: 'String' do 
	#	if object.price > 1
	#		"#{object.price.to_s} #{object.price_unit}s"
	#	else
	#		"#{object.price.to_s} #{object.price_unit}"
	#	end
	#{}"#{pluralize(object.price, object.price_unit)}"
	#end
	field :main_pict, type: 'String' do
		unless object.fabric_pictures.view.empty?
			data = object.fabric_pictures.view.as_json
			#puts  JSON.pretty_generate data
			data = data[0]['image'].thumb.url
			#puts ' main_pict datas are : ' + data
			data
		end	
	end
	field :preview_pict, type: 'boolean' do
		unless object.fabric_pictures.preview.empty?
			true
		end	
	end
	field :nb_pict, type: 'String' do
		object.fabric_pictures.count || 0
	end
	field :online, type: 'Boolean' do
		if object.on_site? == true
			true
		else
			false
		end
	end

	segment 'Fabrics on site' do
		{ id: Fabric.on_site.map(&:id) }
	end
end

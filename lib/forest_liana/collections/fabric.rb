class Forest::Fabric
	include ForestLiana::Collection

	collection :fabrics
	field :prices, type: 'String' do
		"#{object.price.to_s} #{object.price_unit}"
	end
	
end

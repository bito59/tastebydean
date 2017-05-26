class Forest::Order
	include ForestLiana::Collection

	collection :orders

	field :nb_line, type: 'String' do
		object.order_lines.count || 0
	end

end

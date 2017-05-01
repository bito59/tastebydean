#require 'action_view'
class Forest::Fabric
	#include ActionView::Helpers::TextHelper
	include ForestLiana::Collection

	#collection :fabrics
	#field :prices, type: 'String' do 
	#	if object.price > 1
	#		"#{object.price.to_s} #{object.price_unit}s"
	#	else
	#		"#{object.price.to_s} #{object.price_unit}"
	#	end
	#{}"#{pluralize(object.price, object.price_unit)}"
	#end
	#field :online, type: 'Boolean' do
	#	if object.on_site? == true
	#		true
	#	else
	#		false
	#	end
	#end

	#segment 'Fabrics on site' do
	#	{ id: Fabric.on_site.map(&:id) }
	#end
end

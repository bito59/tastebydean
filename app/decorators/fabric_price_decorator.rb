class FabricPriceDecorator < ApplicationDecorator
	include Drape::LazyHelpers
	include ApplicationHelper

	delegate_all

	#def show_price
	#	self.price.to_s + " " + self.price_unit
	#end

end

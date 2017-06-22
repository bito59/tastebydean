class ApplicationDecorator < Drape::Decorator
	include Drape::LazyHelpers
	#include ApplicationHelper

# --------    Site prices  -----------------------------------------

	def show_price_in_local_currency(key)
		price = self[key.to_sym] * 1
		t('common.euro', count: price)
	end

end

class OrderDecorator < ApplicationDecorator

	delegate_all
	decorates_association :order_lines

end

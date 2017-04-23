class OrderLine < ApplicationRecord

	belongs_to :order
	belongs_to :product
	belongs_to :fabric

	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

	before_save :finalize

# ---------------- Methods and selects  -----------------------------------------------------------------------------

	SERVICE = ['SELLING', 'CONFECTION', 'ALL']


	def unit_price
		if persisted?
			self[:unit_price]
		else
			product.price
		end
	end

	def fabric_price
		if persisted?
			self[:fabric_price]
		else
			#fabric.price
			0
		end
	end

	def total_price
		unit_price * quantity
	end

	private

	def product_present
		if product.nil?
			errors.add(:product, "is not valid or is not active.")
		end
	end

	def order_present
		if order.nil?
			errors.add(:order, "is not a valid order.")
		end
	end

	def finalize
		self[:unit_price] = unit_price
		self[:fabric_price] = fabric_price
		self[:total_price] = quantity * (self[:unit_price])
		# + self[:fabric_price] * product.fab_length)
	end

end

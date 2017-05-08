class OrderLine < ApplicationRecord

	belongs_to :order
	belongs_to :product
	belongs_to :fabric

	validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
	validate :product_present
	validate :order_present

	before_save :update_price

# ---------------- Methods and selects  -----------------------------------------------------------------------------


	def calc_unit_price
		if persisted?
			self[:confection_price] + self[:fabric_price]
		else
			confection_price + fabric_price
		end
	end

	def calc_price
		calc_unit_price * quantity
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

	def update_price
		#sets the price of the cart item to the price of the product + fabric
		self[:unit_price] = calc_unit_price
		self[:total_price] = quantity * self[:unit_price]
		puts 'price updated with :' + self[:unit_price].to_s + ' and ' + self[:total_price].to_s
	end

end

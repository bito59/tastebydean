# == Schema Information
#
# Table name: order_lines
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  product_id       :integer
#  fabric_id        :integer
#  std_size         :boolean          default("1")
#  sep_fabric       :boolean          default("1")
#  confection_price :decimal(12, 3)   default("0.000")
#  fabric_price     :decimal(12, 3)   default("0.000")
#  unit_price       :decimal(12, 3)   default("0.000")
#  quantity         :integer          default("1")
#  total_price      :decimal(12, 3)   default("0.000")
#  price_unit       :string(255)      default("€")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class OrderLine < ApplicationRecord

	belongs_to :order
	belongs_to :product
	belongs_to :fabric
	has_many :product_pictures, through: :product
	has_many :fabric_pictures, through: :fabric

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

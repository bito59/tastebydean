# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  serial            :string
#  status            :string
#  delivery_method   :string
#  title             :string
#  name              :string
#  surname           :string
#  address           :string
#  zipcode           :string
#  city              :string
#  country           :string
#  phone             :string
#  subtotal          :decimal(12, 3)   default("0")
#  shipping_fees     :decimal(12, 3)   default("0")
#  tax_fees          :decimal(12, 3)   default("0")
#  share_discount    :decimal(, )      default("0")
#  num_discount      :decimal(12, 3)   default("0")
#  total             :decimal(12, 3)   default("0")
#  price_unit_id     :integer
#  payment_method    :string
#  payment_type      :string
#  payment_status    :string
#  creation_date     :datetime
#  validation_date   :datetime
#  confirmation_date :datetime
#  expedition_date   :datetime
#  payment_date      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_orders_on_price_unit_id  (price_unit_id)
#  index_orders_on_user_id        (user_id)
#

class Order < ApplicationRecord

	before_create :init_order_params
	before_save :update_subtotal, :update_total
	after_save :affect_serial

	belongs_to :user
	has_many :order_lines, dependent: :destroy
	has_many :products, through: :order_lines
	accepts_nested_attributes_for :order_lines
	belongs_to :price_unit

	attr_accessor :accept_conditions

# ---------------- Scopes -------------------------------------------------------------------------

	scope :status, -> (status) { where status: status }

# ---------------- Methods and selects  -----------------------------------------------------------------------------

	STATUS = ['basket','passed', 'confirmed', 'shipped', 'canceled','returned']
	DELIVERY_METHOD = ['collect', 'ship']
	PAYMENT_METHOD = ['paypal', 'check', 'proposal']
	PAYMENT_MODE = ['cash', 'check', 'transfert','CB']
	PAYMENT_TYPE = ['on-order', 'on-delivery', '50/50', 'proposal']
	PAYMENT_STATUS = ['due','paid', 'offered']
	TITLES = ['Mr','Mme','Mlle']

	def affect_serial
		if self.serial.nil?
			self.serial = "D" + Time.now.year.to_s.last(2) + "%.4d"%self.id 
			self.save!
		end
	end

	def calc_subtotal
		order_lines.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
	end

	def calc_total
		(self[:subtotal] + self[:shipping_fees] + self[:tax_fees] + self[:num_discount])*(1-self[:share_discount])
	end

	def calc_shipping_fees
		if self[:delivery_method] == 'collect'
			0
		else
			5
		end
	end

	def change_order_status(status)
		self.status = status
		self.save!
	end

	def count_qties
		if self.order_lines.any?
			self.order_lines.sum(:quantity)
		else
			0
		end
	end

	private

	def init_order_params
		self.status = 'basket'
		self.shipping_fees = 0
		self.tax_fees = 0
		self.share_discount = 0
		self.num_discount = 0
	end

	def update_subtotal
		self[:subtotal] = calc_subtotal
	end

	def update_total
		self[:shipping_fees] = calc_shipping_fees
		self[:total] = calc_total
	end

end

class Order < ApplicationRecord

	before_create :init_order_params
	before_save :update_subtotal, :update_total
	after_save :affect_serial

	belongs_to :user
	has_many :order_lines, dependent: :destroy
	has_many :products, through: :order_lines
	accepts_nested_attributes_for :order_lines

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
		self[:total] = calc_total
	end

end

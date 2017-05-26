class Product < ApplicationRecord
	extend FriendlyId
  	friendly_id :serial, use: :slugged

	belongs_to :customer
	belongs_to :product_family
	belongs_to :measure
	has_many :order_lines
	has_many :orders, through: :order_lines
  	has_many :product_pictures, dependent: :destroy
	accepts_nested_attributes_for :product_pictures, allow_destroy: true

  	after_save :affect_serial # Needs product ID
	validates_uniqueness_of :serial, message: "This serial number is already used"
	validates_presence_of :kind, :customer, :product_family, :title

# ---------------- Scopes -------------------------------------------------------------------------

	scope :on_site, -> { joins(:product_pictures)
		.where('product_pictures.activated = ?',true)
		.where('product_pictures.main = ?',true)
		.group("products.id")
		.having("count(product_pictures.id) > ?",0)
		.where('products.activated = ?',true)
	}
	scope :random, -> { order('RAND()') }

	scope :all_creations, -> { where kind: 'creation' }
	scope :all_models, -> { where kind: 'model' }
	scope :all_fabrics, -> { where kind: 'fabric' }
	scope :all_accessories, -> { where kind: 'accessory' }

	scope :new_product, -> { where new_product: true }
	scope :with_discount, -> { where discount: true }
	
	scope :with_kind, -> (kind) { where kind: kind }
	#scope :with_product_family, -> (family) { where product_family: family }
	scope :with_customer, -> (customer, age) { joins(:customer)
		.where('customers.title = ? OR customers.title = ? OR customers.title = ?', customer, age, 'all')
	}

# ---------------- Options & functions -----------------------------------------------------------------------------

	enum kind: [:model, :accessory, :creation]

	def load_sizes
		unless self.unic_size?
			sizes = {std: self.customer.title.downcase + '_std', big: self.customer.title.downcase + '_big'}
		end
	end

	def on_site?
		if self.activated == true && self.product_pictures.active.main.count > 0
			true
		else
			false
		end
	end

	private

	def affect_serial
		if self[:kind] == 'creation' 
			serial = "C" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		elsif self[:kind] == 'model'
			serial = "M" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		elsif self[:kind] == 'accessory'
			serial = "A" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		else
			serial = "PROBLEM - " + self.id.to_s
		end
		self.update_column(:serial, serial)
		self.update_column(:slug, serial)
	end
end

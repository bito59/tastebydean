class Product < ApplicationRecord
	extend FriendlyId
  	friendly_id :serial, use: :slugged

  	has_many :product_pictures, dependent: :destroy
	accepts_nested_attributes_for :product_pictures, allow_destroy: true
	has_many :order_lines
	has_many :orders, through: :order_lines
	belongs_to :measure

  	after_save :affect_serial # Needs product ID
	validates_uniqueness_of :serial, message: "This serial number is already used"
	validates_presence_of :kind, :customer, :family, :title

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
	scope :with_family, -> (family) { where family: family }
	scope :with_customer, -> (customer) { where customer: customer }
	scope :adult, -> { where("customer = ? or customer = ?", 'man', 'woman') }
	scope :child, -> { where("customer = ? or customer = ?", 'boy', 'girl') }

# ---------------- Options & functions -----------------------------------------------------------------------------

	enum kind: [:model, :accessory, :creation]
	enum customer: [:man, :woman, :boy, :girl]
	enum family: [:dress, :jacket, :hat, :tie, :bow_tie, :neck_tie]
	enum price_unit: [:euro]
	enum measure_unit: [:m, :cm]

	#KINDS = ['model', 'accessory', 'creation']
	#CUSTOMERS = ['man', 'woman', 'boy', 'girl']
	#FAMILIES = {
	#	female: ['dress','jacket','hat'],
	#	male: ['tie','bow-tie','neck-tie','jacket'],
	#	material: ['silk','cotton-silk','cotton']
	#}
	#PRICE_UNITS = ['€']
	#MEASURE_UNITS = ['m','cm']

	def find_sizes
		if self.unic_size == false
			sizes = {std: self.customer + '_std', big: self.customer + '_big'}
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

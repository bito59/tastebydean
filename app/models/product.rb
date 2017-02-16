class Product < ApplicationRecord
	extend FriendlyId
  	friendly_id :serial, use: :slugged

  	mount_uploaders :pictures, PictureUploader
  	serialize :pictures, JSON

	has_many :product_pictures, dependent: :destroy
	accepts_nested_attributes_for :product_pictures, allow_destroy: true
	has_many :order_lines
	has_many :orders, through: :order_lines

	validates_presence_of :kind, :customer, :family, :title, :price, :price_unit
	validates_uniqueness_of :serial, message: "This serial number is already used"

# ---------------- Scopes -------------------------------------------------------------------------

	scope :with_picture, -> { joins(:product_pictures).where('product_pictures.activated = ?',true).group("products.id").having("count(product_pictures.id) > ?",0) }
	scope :random, -> { order('RAND()') }

	scope :all_creations, -> { where kind: 'creation' }
	scope :all_models, -> { where kind: 'model' }
	scope :all_fabrics, -> { where kind: 'fabric' }
	scope :all_accessories, -> { where kind: 'accessory' }

	scope :actives, -> { where activated: true }
	scope :new_product, -> { where new_product: true }
	scope :with_discount, -> { where discount: true }
	
	scope :with_kind, -> (kind) { where kind: kind }
	scope :with_family, -> (family) { where family: family }
	scope :with_customer, -> (customer) { where customer: customer }
	scope :adult, -> { where("customer = ? or customer = ?", 'man', 'woman') }
	scope :child, -> { where("customer = ? or customer = ?", 'boy', 'girl') }


# ---------------- Options & functions -----------------------------------------------------------------------------

	KINDS = ['model', 'accessory', 'creation']
	CUSTOMERS = ['man', 'woman', 'boy', 'girl']
	FAMILIES = {
		female: ['dress','jacket','hat'],
		male: ['tie','bow-tie','neck-tie','jacket'],
		material: ['silk','cotton-silk','cotton']
	}
	PRICE_UNITS = ['€']
	MEASURE_UNITS = ['m','cm']

	def affect_serial
		if self[:kind] == 'creation' 
			self.serial = "C" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		elsif self[:kind] == 'model'
			self.serial = "M" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		elsif self[:kind] == 'accessory'
			self.serial = "A" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		end
		self.slug = self.serial
		self.save!
	end

	def find_sizes
		if self.variable_size == true
			#a = self.customer + '_small'
			sizes = {std: self.customer + '_std', big: self.customer + '_big'}
		end
	end

end

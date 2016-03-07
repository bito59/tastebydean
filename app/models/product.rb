class Product < ActiveRecord::Base

	attr_accessor :nb_stars
	extend FriendlyId
		friendly_id :title, use: :slugged

	has_one :gallery, dependent: :destroy
	has_many :pictures, through: :gallery

	validates_uniqueness_of :title, :message => "This cook name is already used"
	validates_presence_of :title, :kind, :family, :customer, :price, :price_unit, :measure, :measure_unit

	include Filterable
	scope :kind, -> (kind) { where kind: kind }
	scope :new_product, -> (new_product) { where new_product: new_product }
	scope :family, -> (family) { where family: family }
	scope :customer, -> (customer) { where customer: customer }


	KINDS = [
		'model-male',
		'model-female',
		'material'
	]

	MATERIAL_FAMILIES = [
		'silk',
		'cotton-silk',
		'cotton'
	]

	MALE_CUSTOMERS = [
		'man',
		'boy'
	]

	FEMALE_CUSTOMERS = [
		'woman',
		'girl'
	]

	MALE_FAMILIES = [
		'tie',
		'bow-tie',
		'neck-tie',
	]

	FEMALE_FAMILIES = [
		'robe',
		'jacket',
		'hair-clip'
	]

	PRICE_UNITS = [
		'€'
	]

	MEASURE_UNITS = [
		'meter'
	]

	def rating
		#self.nb_stars = Comment.where(:product_id == self.id).count
		self.nb_stars = 2
	end
	
end

class Product < ActiveRecord::Base

	#extend FriendlyId
		#friendly_id :serial_number, use: :slugged

	has_one :gallery, dependent: :destroy
	has_many :pictures, through: :gallery

	#validates_uniqueness_of :serial_number, :message => "Serial number is already used"
	validates_presence_of :serial, :title, :kind, :customer, :family, :price, :price_unit, :measure, :measure_unit

	include Filterable
	filterrific(
	  default_filter_params: { sorted_by: 'created_at_desc' },
	  available_filters: [
	    :sorted_by,
	    :activated
	  ]
	)
	#default_scope { where("removed_at IS NULL") }
	scope :kind, -> (kind) { where kind: kind }
	scope :activated, -> { where activated: true }
	scope :new_product, -> (new_product) { where new_product: new_product }
	scope :family, -> (family) { where family: family }
	scope :customer, -> (customer) { where customer: customer }
	scope :sorted_by, lambda { |sort_option|
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^created_at_/
	    order("products.created_at #{ direction }")
	  when /^title_/
	    order("LOWER(products.title) #{ direction }")
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
	}

	def serial_number
		"D" + Time.now.year.to_s.last(2) + "%.4d"%self.id
	end

	KINDS = ['model','material']
	CUSTOMERS = ['man', 'woman', 'boy', 'girl']
	FAMILIES = {
		female: ['robe','jacket','hair-clip'],
		male: ['tie','bow-tie','neck-tie'],
		material: ['silk','cotton-silk','cotton']
	}
	PRICE_UNITS = ['€']
	MEASURE_UNITS = ['meter']
	EVENTS = ['new','discount']
	
end

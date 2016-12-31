class Fabric < ApplicationRecord

	has_many :order_lines
	has_many :orders, through: :order_lines


	# ---------------- Options & functions -----------------------------------------------------------------------------

	KINDS = ['silk', 'cotton', 'cotton-silk']
	PRICE_UNITS = ['€']
	MEASURE_UNITS = ['m','cm']

	def affect_serial
		self.serial = "F" + Time.now.year.to_s.last(2) + "%.4d"%self.id
		self.save!
	end

end

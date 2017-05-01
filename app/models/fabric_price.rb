class FabricPrice < ApplicationRecord
	belongs_to :product_family
	belongs_to :fabric_family
end

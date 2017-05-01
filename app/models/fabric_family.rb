class FabricFamily < ApplicationRecord
	has_many :fabrics, dependent: :destroy
	has_many :fabric_prices, dependent: :destroy
end

class ProductFamily < ApplicationRecord
	has_many :products, dependent: :destroy
	has_many :fabric_prices, dependent: :destroy
end

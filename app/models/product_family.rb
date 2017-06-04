# == Schema Information
#
# Table name: product_families
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductFamily < ApplicationRecord
	has_many :products, dependent: :destroy
	has_many :fabric_prices, dependent: :destroy
end

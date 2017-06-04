# == Schema Information
#
# Table name: fabric_prices
#
#  id                :integer          not null, primary key
#  title             :string(255)
#  product_family_id :integer
#  fabric_family_id  :integer
#  price_std         :decimal(8, 2)
#  price_big         :decimal(8, 2)
#  price_unit        :string(255)      default("€")
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class FabricPrice < ApplicationRecord
	belongs_to :product_family
	belongs_to :fabric_family
end

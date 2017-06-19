# == Schema Information
#
# Table name: fabric_prices
#
#  id                :integer          not null, primary key
#  title             :string
#  product_family_id :integer
#  fabric_family_id  :integer
#  price_std         :decimal(8, 2)
#  price_big         :decimal(8, 2)
#  price_unit_id     :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_fabric_prices_on_fabric_family_id   (fabric_family_id)
#  index_fabric_prices_on_price_unit_id      (price_unit_id)
#  index_fabric_prices_on_product_family_id  (product_family_id)
#

require 'test_helper'

class FabricPriceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

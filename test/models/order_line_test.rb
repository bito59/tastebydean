# == Schema Information
#
# Table name: order_lines
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  product_id       :integer
#  fabric_id        :integer
#  std_size         :boolean          default("true")
#  sep_fabric       :boolean          default("true")
#  confection_price :decimal(12, 3)   default("0")
#  fabric_price     :decimal(12, 3)   default("0")
#  unit_price       :decimal(12, 3)   default("0")
#  quantity         :integer          default("1")
#  total_price      :decimal(12, 3)   default("0")
#  price_unit_id    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_order_lines_on_fabric_id      (fabric_id)
#  index_order_lines_on_order_id       (order_id)
#  index_order_lines_on_price_unit_id  (price_unit_id)
#  index_order_lines_on_product_id     (product_id)
#

require 'test_helper'

class OrderLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

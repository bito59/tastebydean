# == Schema Information
#
# Table name: order_lines
#
#  id               :integer          not null, primary key
#  order_id         :integer
#  product_id       :integer
#  fabric_id        :integer
#  std_size         :boolean          default("1")
#  sep_fabric       :boolean          default("1")
#  confection_price :decimal(12, 3)   default("0.000")
#  fabric_price     :decimal(12, 3)   default("0.000")
#  unit_price       :decimal(12, 3)   default("0.000")
#  quantity         :integer          default("1")
#  total_price      :decimal(12, 3)   default("0.000")
#  price_unit       :string(255)      default("€")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class OrderLineTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

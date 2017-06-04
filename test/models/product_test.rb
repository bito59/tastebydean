# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  serial            :string(255)
#  title             :string(255)
#  activated         :boolean          default("0")
#  kind              :integer          default("1")
#  customer_id       :integer
#  product_family_id :integer
#  measure_id        :integer
#  description       :text(65535)
#  confection_price  :decimal(8, 2)
#  price_unit        :string(255)      default("€")
#  leadtime          :string(255)
#  custom_fabric     :boolean          default("1")
#  on_measure        :boolean          default("1")
#  unic_size         :boolean          default("1")
#  fabric_lng_std    :float(24)
#  fabric_lrg_std    :float(24)
#  fabric_lng_big    :float(24)
#  fabric_lrg_big    :float(24)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  slug              :string(255)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

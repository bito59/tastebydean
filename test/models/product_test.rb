# == Schema Information
#
# Table name: products
#
#  id                :integer          not null, primary key
#  serial            :string
#  title             :string
#  activated         :boolean          default("false")
#  kind              :integer          default("1")
#  customer_id       :integer
#  product_family_id :integer
#  measure_id        :integer
#  description       :text
#  confection_price  :decimal(8, 2)
#  price_unit_id     :integer
#  leadtime          :string
#  custom_fabric     :boolean          default("true")
#  on_measure        :boolean          default("true")
#  unic_size         :boolean          default("true")
#  fabric_lng_std    :float
#  fabric_lrg_std    :float
#  fabric_lng_big    :float
#  fabric_lrg_big    :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  slug              :string
#
# Indexes
#
#  index_products_on_customer_id        (customer_id)
#  index_products_on_measure_id         (measure_id)
#  index_products_on_price_unit_id      (price_unit_id)
#  index_products_on_product_family_id  (product_family_id)
#  index_products_on_slug               (slug) UNIQUE
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

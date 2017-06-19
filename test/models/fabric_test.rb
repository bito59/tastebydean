# == Schema Information
#
# Table name: fabrics
#
#  id               :integer          not null, primary key
#  serial           :string
#  kind             :string           default("fabric")
#  title            :string
#  fabric_family_id :integer
#  activated        :boolean          default("false")
#  origin           :string
#  content          :string
#  description      :text
#  stock_length     :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string
#
# Indexes
#
#  index_fabrics_on_fabric_family_id  (fabric_family_id)
#

require 'test_helper'

class FabricTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

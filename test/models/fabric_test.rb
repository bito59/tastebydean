# == Schema Information
#
# Table name: fabrics
#
#  id               :integer          not null, primary key
#  serial           :string(255)
#  kind             :string(255)      default("fabric")
#  title            :string(255)
#  fabric_family_id :integer
#  activated        :boolean          default("0")
#  image            :text(65535)
#  origin           :string(255)
#  content          :string(255)
#  description      :text(65535)
#  stock_length     :float(24)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string(255)
#

require 'test_helper'

class FabricTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

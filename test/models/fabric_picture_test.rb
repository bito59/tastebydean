# == Schema Information
#
# Table name: fabric_pictures
#
#  id         :integer          not null, primary key
#  fabric_id  :integer
#  activated  :boolean          default("true")
#  main       :boolean          default("false")
#  preview    :boolean          default("false")
#  image      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_fabric_pictures_on_fabric_id  (fabric_id)
#

require 'test_helper'

class FabricPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

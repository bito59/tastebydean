# == Schema Information
#
# Table name: fabric_pictures
#
#  id         :integer          not null, primary key
#  fabric_id  :integer
#  activated  :boolean          default("1")
#  main       :boolean          default("0")
#  preview    :boolean          default("0")
#  image      :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FabricPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: product_pictures
#
#  id         :integer          not null, primary key
#  product_id :integer
#  main       :boolean          default("0")
#  activated  :boolean          default("1")
#  image      :text(65535)
#

require 'test_helper'

class ProductPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

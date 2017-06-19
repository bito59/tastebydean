# == Schema Information
#
# Table name: product_pictures
#
#  id         :integer          not null, primary key
#  product_id :integer
#  main       :boolean          default("false")
#  activated  :boolean          default("true")
#  image      :text
#
# Indexes
#
#  index_product_pictures_on_product_id  (product_id)
#

require 'test_helper'

class ProductPictureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

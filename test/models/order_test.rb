# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  serial            :string(255)
#  status            :string(255)
#  delivery_method   :string(255)
#  title             :string(255)
#  name              :string(255)
#  surname           :string(255)
#  address           :string(255)
#  zipcode           :string(255)
#  city              :string(255)
#  country           :string(255)
#  phone             :string(255)
#  subtotal          :decimal(12, 3)   default("0.000")
#  shipping_fees     :decimal(12, 3)   default("0.000")
#  tax_fees          :decimal(12, 3)   default("0.000")
#  share_discount    :decimal(10, )    default("0")
#  num_discount      :decimal(12, 3)   default("0.000")
#  total             :decimal(12, 3)   default("0.000")
#  payment_method    :string(255)
#  payment_type      :string(255)
#  payment_status    :string(255)
#  creation_date     :datetime
#  validation_date   :datetime
#  confirmation_date :datetime
#  expedition_date   :datetime
#  payment_date      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

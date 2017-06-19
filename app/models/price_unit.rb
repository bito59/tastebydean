# == Schema Information
#
# Table name: price_units
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PriceUnit < ApplicationRecord
	has_many :product
	has_many :fabric_price
	has_many :order
	has_many :order_line
end

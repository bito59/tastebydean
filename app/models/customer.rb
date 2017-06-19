# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ApplicationRecord
	has_many :products
end

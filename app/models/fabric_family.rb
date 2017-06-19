# == Schema Information
#
# Table name: fabric_families
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FabricFamily < ApplicationRecord
	has_many :fabrics, dependent: :destroy
	has_many :fabric_prices, dependent: :destroy
end

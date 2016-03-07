class Gallery < ActiveRecord::Base

	belongs_to :product
	has_many :pictures, dependent: :destroy
	#accepts_nested_attributes_for :pictures

end

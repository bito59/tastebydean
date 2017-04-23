class User < ApplicationRecord

  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
	has_many :order_lines, through: :orders

end

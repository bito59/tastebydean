class User < ActiveRecord::Base
	rolify
	include Authority::UserAbilities

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	validates :pseudo, presence: { message: "Pseudo is required" } , uniqueness: { message: "Pseudo already used" }
	validates :email, presence: { message: "Email is required" } , uniqueness: { message: "Email already used" }  

	has_attached_file :avatar, 
		styles: { thumb: "200x200#" }, default_url: "avatar/default.jpg",
		:path => "/users/:id/avatar/:filename"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

	# friendly_ID to show the pseudo of users instead of IDs
	extend FriendlyId
	friendly_id :pseudo, use: :slugged

	def admin?
    	self.has_role? :admin
  	end

end

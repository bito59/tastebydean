# == Schema Information
#
# Table name: fabric_pictures
#
#  id         :integer          not null, primary key
#  fabric_id  :integer
#  activated  :boolean          default("true")
#  main       :boolean          default("false")
#  preview    :boolean          default("false")
#  image      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_fabric_pictures_on_fabric_id  (fabric_id)
#

class FabricPicture < ApplicationRecord

	belongs_to :fabric
	before_destroy :destroy_assets
	mount_uploader :image, FabricPictureUploader
	validate :image_size_validation

# ---------------- Scopes -------------------------------------------------------------------------

	scope :active, -> { where activated: true }
	scope :main, -> { where main: true }
	scope :preview, -> { where(preview: true).order(main: :desc) }
	scope :view, -> { where(preview: false).order(main: :desc)}

# ---------------- Options & functions -----------------------------------------------------------------------------

	private

	def image_size_validation
		errors[:image] << "should be less than 10MB" if image.size > 10.megabytes
	end

	def destroy_assets
		self.image.remove! if self.image
		self.save!
	end

end

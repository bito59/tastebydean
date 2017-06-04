# == Schema Information
#
# Table name: measures
#
#  id                         :integer          not null, primary key
#  title                      :string(255)
#  around_collar_large        :boolean          default("0")
#  shoulder_width             :boolean          default("0")
#  shoulder_waist_front_large :boolean          default("0")
#  shoulder_waist_back_large  :boolean          default("0")
#  back_width                 :boolean          default("0")
#  chest_width                :boolean          default("0")
#  around_bust_large          :boolean          default("0")
#  bust_height                :boolean          default("0")
#  around_waist_large         :boolean          default("0")
#  elbow_length               :boolean          default("0")
#  around_arm_large           :boolean          default("0")
#  arm_lenght                 :boolean          default("0")
#  around_hip_height          :boolean          default("0")
#  around_hip_large           :boolean          default("0")
#  half_hip_height            :boolean          default("0")
#  crotch_length              :boolean          default("0")
#  knee_lenght                :boolean          default("0")
#  leg_length                 :boolean          default("0")
#  inside_leg_length          :boolean          default("0")
#  around_leg_large           :boolean          default("0")
#  total_height               :boolean          default("0")
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Measure < ApplicationRecord
	has_many :products
end

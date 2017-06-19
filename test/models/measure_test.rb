# == Schema Information
#
# Table name: measures
#
#  id                         :integer          not null, primary key
#  title                      :string
#  around_collar_large        :boolean          default("false")
#  shoulder_width             :boolean          default("false")
#  shoulder_waist_front_large :boolean          default("false")
#  shoulder_waist_back_large  :boolean          default("false")
#  back_width                 :boolean          default("false")
#  chest_width                :boolean          default("false")
#  around_bust_large          :boolean          default("false")
#  bust_height                :boolean          default("false")
#  around_waist_large         :boolean          default("false")
#  elbow_length               :boolean          default("false")
#  around_arm_large           :boolean          default("false")
#  arm_lenght                 :boolean          default("false")
#  around_hip_height          :boolean          default("false")
#  around_hip_large           :boolean          default("false")
#  half_hip_height            :boolean          default("false")
#  crotch_length              :boolean          default("false")
#  knee_lenght                :boolean          default("false")
#  leg_length                 :boolean          default("false")
#  inside_leg_length          :boolean          default("false")
#  around_leg_large           :boolean          default("false")
#  total_height               :boolean          default("false")
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'test_helper'

class MeasureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  zipcode    :string
#  email      :string
#  country    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

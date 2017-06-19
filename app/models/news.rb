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

class News < ApplicationRecord
end

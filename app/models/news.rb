# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  zipcode    :string(255)
#  email      :string(255)
#  country    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class News < ApplicationRecord
end

# == Schema Information
#
# Table name: details
#
#  id         :integer          not null, primary key
#  address    :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_details_on_user_id  (user_id)
#

class Detail < ApplicationRecord
  belongs_to :user
end
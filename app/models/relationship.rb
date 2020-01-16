# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  featured_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_relationships_on_user_id  (user_id)
#

class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :featured, class_name: "User"
end

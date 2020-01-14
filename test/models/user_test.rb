# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  confirm_token   :string
#  email           :string
#  email_confirmed :boolean          default(FALSE)
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

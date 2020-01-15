# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  active          :boolean          default(TRUE)
#  admin           :boolean          default(FALSE)
#  confirm_token   :string
#  email           :string
#  email_confirmed :boolean          default(FALSE)
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user_count" do
    assert_equal 20, users.length
  end
  # test "the truth" do
  #   assert true
  # end
end

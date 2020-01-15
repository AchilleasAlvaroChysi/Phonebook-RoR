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

class User < ApplicationRecord
	has_secure_password
	before_create	:confirmation_token
	validates :email, presence: true, uniqueness: true
	validates_confirmation_of :password
	has_many :details
	accepts_nested_attributes_for :details
	
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, through: :friend_requests, source: :friend

	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships	  
	

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save
	  end

	def remove_friend(friend)
		current_user.friends.destroy(friend)
	  end
	private
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end
end

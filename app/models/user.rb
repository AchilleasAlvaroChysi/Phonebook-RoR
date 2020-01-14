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

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save
	  end

	private
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end
end

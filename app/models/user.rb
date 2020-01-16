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

class User < ApplicationRecord
	has_secure_password
	before_create	:confirmation_token
	validates :email, presence: true, uniqueness: true
	has_many :details
	accepts_nested_attributes_for :details
	has_many :relationships
	has_many :featured, through: :relationships

	def email_activate
		self.email_confirmed = true
		self.confirm_token = nil
		save
	  end
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
														BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	def account_activate
		self.active = true
		save
	end

	def account_deactivate
		self.active = false
		save
	end

	def feature(other_user)
		unless featured.length ==5
			featured << other_user
		else 
			unfeature(featured.first)
			featured << other_user
		end
	end
	
	def unfeature(other_user)
		unless featured.length ==0
			featured.delete(other_user)
		end
	end
	private
	
	def confirmation_token
		if self.confirm_token.blank?
			self.confirm_token = SecureRandom.urlsafe_base64.to_s
		end
	end
end

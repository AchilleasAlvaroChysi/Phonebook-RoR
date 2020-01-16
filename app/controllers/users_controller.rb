class UsersController < ApplicationController

	skip_before_action :authorized, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.valid?
		if @user.save
			UserMailer.registration_confirmation(@user).deliver
			flash[:success]= "Signup successful. Welcome to the site! Please confirm your email"
			session[:user_id] = @user.id
			redirect_to root_url
		else
			flash[:warning] = "There was a problem creating your account. Please try again."
			redirect_to '/welcome'
		end
	end

	def confirm_email
		user = User.find_by_confirm_token(params[:id])
		if user
			user.email_activate
			
			redirect_to root_url
			flash[:success] = "Welcome to the Phonebook App! Your email has been confirmed.
			Please sign in to continue."
		else
			redirect_to root_url
			flash[:danger] = "Sorry. User does not exist"

		end

	end
	def activate 
		user = User.find(params[:id])
		user.account_activate
		redirect_to edit_user_path(user)
	end
	def deactivate
		user = User.find(params[:id])
		user.account_deactivate
		redirect_to edit_user_path(user)

	end

	def get_invitation
		redirect_to root_path
	end

	def invitation_email
		user = User.find(params[:id])
		receiver = params[:receiver]
		if user
			UserMailer.invitation_email(user, receiver).deliver
			redirect_to user_path(user.id)
			flash[:success] = "your invitation has been sent successfully!"

		else
			flash[:error] = "something went wrong with your invitation"
		end
	end

	def index
		@user = User.find(params[:format])
	end

	def feature
		@user = User.find(params[:id])
		@f_user = User.find(params[:feature_id])
		@user.feature(@f_user)
		redirect_back(fallback_location: root_path)
	end

	def unfeature
		@user = User.find(params[:id])
		@f_user = User.find(params[:feature_id])
		@user.unfeature(@f_user)
		redirect_back(fallback_location: root_path)
	end
	def show
		user = User.find(params[:id])
		if !user.details.any?
			redirect_to new_user_detail_path(user)
			flash[:warning] = "you should have at least one piece of info for you"
			return
		end
		
	end
	private
	
	def user_params
		params.require(:user).permit(:email, :password)
	end
end

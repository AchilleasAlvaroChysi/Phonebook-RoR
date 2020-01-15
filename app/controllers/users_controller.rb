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
			flash[:alert] = "There was a problem creating your account. Please try again."
			redirect_to '/welcome'
		end
  end

	def confirm_email
		user = User.find_by_confirm_token(params[:id])
		if user
			user.email_activate
			flash[:success] = "Welcome to the Phonebook App! Your email has been confirmed.
			Please sign in to continue."
			redirect_to root_url
		else
			flash[:error] = "Sorry. User does not exist"
			redirect_to root_url
		end

	end

  def index
	@user = User.find(current_user.id)
	@users= User.all
  end
  def show
	@user = User.find(params[:id])
	@users= User.all
  end
  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end
  def show
	user = User.find(params[:id])
	if !user.details.any?
		flash.alert = "you should have at least one piece of info for you"
		redirect_to new_user_detail_path(user)
		return
	  end
  end

  def user_params
	  params.require(:user).permit(:email, :password)
  end
end

class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]

  def new
	  @user = User.new
  end

  def create
	  @user = User.new(user_params)
		if @user.save
			flash[:notice]= "Signup successful. Welcome to the site!"
			session[:user_id] = @user.id
			redirect_to user_path(@user)
		end
  end

  def index
  end

  def show
  end

  def user_params
	  params.require(:user).permit(:email, :password)
  end
end

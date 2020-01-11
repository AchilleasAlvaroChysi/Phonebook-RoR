class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
	  @user = User.find_by(email: params[:email])
	  if @user && @user.authenticate(params[:password])
		  session[:user_id] = @user.id
		  redirect_to user_path(@user)
	  else
      flash.now[:alert] = "Couldn't login with your credentials"
		  redirect_to '/login'
	  end
  end
  def destroy
    session[:user_id] = nil
    redirect_to "/welcome"
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
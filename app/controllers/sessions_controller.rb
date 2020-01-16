class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    # user = User.find_by_email(params[:email].downcase)

    if user && user.authenticate(params[:password])

      if user.email_confirmed 
        session[:user_id] = user.id
        flash[:success]= "Welcome"
        redirect_to user_path(user), sucess: "Welcome"
      else
        flash[:warning] = 'Please activate your account by following the 
        instructions in the account confirmation email you received to proceed'
        redirect_to root_path
      end
	  else
      flash[:warning] = "Couldn't login with your credentials"
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

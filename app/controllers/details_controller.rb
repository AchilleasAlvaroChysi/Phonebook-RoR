class DetailsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @detail = Detail.create()
  end

  def create
    @user = User.find(params[:user_id])
    @detail = Detail.create(detail_params)
    @detail.user_id = @user.id
    @detail.save
    redirect_to user_path(@user)

  end

  def show
    id = params[:id]
    @user = User.find(id)
  end

  def edit
    @detail = Detail.find(params[:id])
    @detail.phone = params[:phone]
    @detail.address = params[:address]
    redirect_back fallback_location: edit_user_path
    
  end
  def destroy
    @detail = Detail.find(params[:id])
    @detail.destroy
    redirect_back fallback_location: edit_user_path

  end

  def has_both?
    @detail = Detail.find(params[:id])
    !(@detail.phone== nil && @detail.address==nil)
  end

  def detail_params
    params.require(:detail).permit(:phone, :address)
  end
end

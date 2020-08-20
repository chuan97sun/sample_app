class UsersController < ApplicationController
  before_action :userprofile, only: :show

  def new
    @user = User.new
  end
  
  def userprofile
     @user  = User.find_by id: params[:id]
     return if @user.present?
     flash[:warning] = "user cannot be detected"
     redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user  
    else
      flash.now[:danger] = "account cannot be created"
      render :new
    end
  end 

  private 

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end
end

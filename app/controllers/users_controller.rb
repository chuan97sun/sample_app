class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.order(:name).page params[:page]
  end

  def new
    @user = User.new
  end
  
  def show
    @microposts = @user.microposts.recent_posts.page params[:page]
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".email_sent"
      redirect_to root_path
    else
      flash.now[:danger] = t ".fail_to_create"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      redirect_to @user
      flash[:success] =  t ".updated_sucessfully"
    else
      flash.now[:danger] = t ".cannot_be_updated"
      render :edit
    end
  end

  def destroy
     if @user.destroy
      flash[:success] =  t ".User_deleted"
    else
      flash[:warning] = t ".fail_to_delete"
    end
    redirect_to users_path
  end


  private 

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def load_user
     @user  = User.find_by id: params[:id]
     return if @user
     
     flash[:warning] = t ".user_cannot_be_detected"
     redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t  ".Please_log_in"
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless current_user? @user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end

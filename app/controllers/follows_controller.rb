class FollowsController < ApplicationController
   def following
    @title = "Following"
    @users = @user.following.page params[:page]
    render "show_follow"
  end

  def followers
    @title = "Followers"
    @users = @user.followers.page params[:page]
    render "show_follow"
  end

   private
  
  def find_user
    @user = User.find id: params[:id]
    return if @user.present?
     
    flash[:danger] = "not the user"
    redirect_to root_path
  end
end

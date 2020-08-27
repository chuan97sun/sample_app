class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      params[:session][:remember_me].eql? Settings.source.collection.session_controller_create ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t ".invalid_email" 
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end

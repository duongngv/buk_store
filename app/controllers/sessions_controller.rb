class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      log_in @user
      remember_me
      redirect_to @user
    else
      flash.now[:danger] = t ".error_signin"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def remember_me
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
  end
end

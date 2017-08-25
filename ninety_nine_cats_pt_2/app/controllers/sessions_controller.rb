class SessionsController < ApplicationController
  before_action :login_check, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user.nil?
      flash.now[:errors] = ['Invalid username or password']
      render :new
    else
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    logout!
    redirect_to cats_url
  end

  def login_check
    if logged_in?
      flash[:errors] = "You are already logged in."
      redirect_to cats_url
    end
  end

end

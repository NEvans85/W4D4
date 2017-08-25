class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logged_in?
    !!current_user
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  protected

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def login_check
    if logged_in?
      flash[:errors] = ["You are already logged in."]
      redirect_to cats_url
    end
  end
end

class ApplicationController < ActionController::Base

  before_filter :set_current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
  def set_current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
    redirect_to login_path unless @current_user
  end

  def is_nurse_or_admin
    if !((@current_user.nurse) or (@current_user.administrator))
      redirect_to login_path
    end
  end

  def is_admin
    if !((@current_user.administrator))
      redirect_to login_path
    end
  end

  def is_nurse
    if !((@current_user.nurse))
      redirect_to login_path
    end
  end

  def access_denied
    flash[:warning] = "Unauthorized action, redirected to the main page."
  end

end

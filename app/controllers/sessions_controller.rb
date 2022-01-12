class SessionsController < ApplicationController

  skip_before_filter :set_current_user

  def new
    if session[:session_token] and User.find_by_session_token(session[:session_token])
      determine_redirect(User.find_by_session_token(session[:session_token]))
      return
    end
  end

  def create
    user = User.find_by_email(params["session"]["email"])
    if user && user.authenticate(params["session"]["password"])
      session[:session_token] = user.session_token
    end
    if not determine_redirect(user)
      flash[:warning] = "Failed to log in"
      session[:session_token] = nil
      redirect_to login_path
    end
  end
  def destroy
    session[:session_token] = nil
    flash[:warning] = "Successfully logged out!"
    @current_user = nil
    redirect_to login_path
  end

  def failure
    flash[:warning] = "Failed to log in"
    redirect_to login_path
  end
  private
  def determine_redirect(user)
    if not user
      false
    elsif user.administrator
      redirect_to administrators_stats_path
    elsif user.nurse
      redirect_to nurse_path(user.nurse)
    elsif user.guardian
      redirect_to guardian_path(user.guardian)
    elsif user.student
      redirect_to student_path(user.student)
    else
      false
    end
  end
end

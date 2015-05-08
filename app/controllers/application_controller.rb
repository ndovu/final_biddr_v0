class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  end

end

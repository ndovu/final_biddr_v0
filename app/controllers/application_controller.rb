class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless session[:user_id].present?
  end
end

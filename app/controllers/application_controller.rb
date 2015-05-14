class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  # def user_auctions
  #   if user_signed_in?
      
  #   else

  #   end
  # end

end

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in! Welcome."
    else
      flash[:alert] = "You did not provide the correct credentials."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out! See you soon."
    redirect_to root_path
  end
end
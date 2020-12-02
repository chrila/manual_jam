class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to root_path, notice: 'Signed in successfully.' }
      else
        format.html { redirect_to new_session_path, alert: 'email and password don\'t match' }
      end
    end
  end

  def destroy
    session.delete(:user_id)
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Logged out successfully.' }
    end
  end
end

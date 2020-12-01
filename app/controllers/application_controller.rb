class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged?
  before_action :authenticate_user!

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged?
    session[:user_id].present?
  end

  def authenticate_user!
    unless logged?
      redirect_to root_path
    end
  end
end

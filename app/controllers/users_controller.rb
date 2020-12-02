class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'User created successfully.' }
      else
        format.html { redirect_to new_user_path, alert: 'User could not be saved.' }
      end
    end
  end

  def show
    @user = User.find(session[:user_id])
    @stories = Story.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

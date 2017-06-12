class UsersController < ApplicationController
	before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      #bypass_sign_in(@user)
      redirect_to root_path
    else
      redirect_to edit_user_path, notice: @user.errors.full_messages.first
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end

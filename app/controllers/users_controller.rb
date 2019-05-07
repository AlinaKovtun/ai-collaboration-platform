# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def show; end

  def update
    if current_user.update(user_params)
      flash.now[:success] = "Avatar updated"
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = "Wrong format"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end

# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def show; end

  def update
    current_user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end

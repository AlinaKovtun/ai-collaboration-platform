# frozen_string_literal: true

class UsersController < ApplicationController
  def edit; end

  def show; end

  def update
    if current_user.update(user_params)
      flash.now[:notice] = t('users.user.notice')
      render 'show'
    else
      flash.now[:alert] = t('users.user.alert')
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar)
  end
end

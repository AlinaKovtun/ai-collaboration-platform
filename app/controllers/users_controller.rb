# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  has_scope :by_roles, type: :array
  respond_to :js, :html, only: %i[index]

  def index
    @roles = Role.visible_to_users
    @users = apply_scopes(User).approved.find_users(params[:search]).paginate(page: params[:page],
                                                                              per_page: 5)
    flash.now[:alert] = t('users.index.alert') if @users.empty?
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if current_user.update(user_params)
      redirect_to user_path(current_user.id), notice: t('users.user.notice')
    else
      flash.now[:alert] = t('users.user.alert')
      render :edit
    end
  end

  def edit_password; end

  def show
    @user = User.find(params[:id])
  end

  def update_password
    if current_user.update_with_password(pass_params)
      redirect_to user_path(current_user.id)
    else
      render :edit_password
    end
  end

  private

  def pass_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def user_params
    params.require(:user).permit(:last_name, :first_name, :about_me, :avatar)
  end
end

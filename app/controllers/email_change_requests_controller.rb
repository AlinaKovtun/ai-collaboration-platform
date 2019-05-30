# frozen_string_literal: true

class EmailChangeRequestsController < ApplicationController
  before_action :authenticate_user!, except: [:approve]
  before_action :find_email_change_request, only: [:approve]
  before_action :delete_old_email_change_request, only: [:create]
  before_action :build_new_email_change_request, only: [:create]
  def update; end

  def new
    @email_change_request = EmailChangeRequest.new
  end

  def create
    @user = current_user
    if current_user.valid_password?(params[:email_change_request][:current_password]) \
       && @email_change_request.save

      MessagesMailer.approve_email(current_user, @email_change_request).deliver_later
      redirect_to news_index_path
    else
      alert_current_password_invalid
      render :new
    end
  end

  def destroy; end

  def approve
    user = @email_change_request.user
    redirect_options = if user.update(email: @email_change_request.email)
                         { notice: t('emailchange.notice') }
                       else
                         { alert: t('emailchange.alert') }
                       end
    @email_change_request.destroy
    redirect_to user_session_path, redirect_options
  end

  private

  def alert_current_password_invalid
    flash[:alert] = t('emailchange.current_password.alert')
  end

  def find_email_change_request
    @email_change_request = EmailChangeRequest.find_by(token: params[:token])
    redirect_to root_path unless @email_change_request
  end

  def build_new_email_change_request
    @email_change_request = current_user.build_email_change_request(email_params)
  end

  def delete_old_email_change_request
    EmailChangeRequest.find_by(user_id: current_user.id)&.destroy
  end

  def email_params
    params.require(:email_change_request).permit(:email)
  end
end

# frozen_string_literal: true

class EmailChangeRequestsController < ApplicationController
  before_action :authenticate_user!, except: [:approve]
  before_action :find_email_change_request, only: [:approve]
  before_action :find_and_delete_email_change_request, only: [:create]
  def update; end

  def new
    @email_change_request = EmailChangeRequest.new
  end

  def create
    if current_user.valid_password?(params[:email_change_request][:current_password]) \
       && @email_change_request.save

      MessagesMailer.approve_email(current_user, @email_change_request).deliver_later
      redirect_to news_index_path
    else
      destroy_and_alert
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

  def destroy_and_alert
    @email_change_request&.destroy
    flash[:alert] = t('emailchange.current_password.alert')
  end

  def find_email_change_request
    @email_change_request = EmailChangeRequest.find_by(token: params[:token])
    redirect_to root_path unless @email_change_request
  end

  def find_and_delete_email_change_request
    @email_change_request = EmailChangeRequest.find_by(user_id: current_user.id)
    @email_change_request&.destroy
    @email_change_request = current_user.create_email_change_request(email_params)
  end

  def email_params
    params.require(:email_change_request).permit(:email)
  end
end

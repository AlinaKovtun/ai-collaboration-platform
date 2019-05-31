# frozen_string_literal: true

class MessagesController < ApplicationController
  def contact_us
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessagesMailer.contact_us_email(@message.as_json).deliver_later
      redirect_to contact_us_path, notice: t('contact_us.notice')
    else
      render 'contact_us'
    end
  end

  private

  def message_params
    params.require(:message).permit(:email, :author_name, :body)
  end
end

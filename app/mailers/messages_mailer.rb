# frozen_string_literal: true

class MessagesMailer < ActionMailer::Base
  def contact_us_email(message)
    @message = message
    mail(
      from: @message.email,
      to: 'soft.darkside@gmail.com',
      subject: 'Contact us'
    )
  end
end

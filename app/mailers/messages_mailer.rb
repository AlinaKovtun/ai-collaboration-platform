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

  def approve_email(user, emailchange)
    @user = user
    @token = emailchange.token
    @new_email = emailchange.email
    mail(from: 'soft.darkside@gmail.com', to: @user.email, subject: 'You change email')
  end
end

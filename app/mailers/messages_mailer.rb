# frozen_string_literal: true

class MessagesMailer < ActionMailer::Base
  def contact_us_email(message)
    @message = message
    mail(
      from: Settings.app_email,
      to: Settings.app_email,
      subject: 'Contact us'
    )
  end

  def approve_email(user, emailchange)
    @user = user
    @token = emailchange.token
    @new_email = emailchange.email
    mail(from: Settings.app_email, to: @user.email, subject: 'You change email')
  end

  def comment_email(commentable, commenter, url)
    @commentable = commentable
    @commenter = commenter
    @url = url
    mail(
      from: Settings.app_email,
      to: @user.email,
      subject: "#{commenter.first_name} leaved comment on your #{@commentable.class}"
    )
  end
end

# frozen_string_literal: true

class EmailSendJob < ActiveJob::Base
  queue_as :default

  def perform(user, emailchange)
    MessagesMailer.approve_email(user, emailchange).deliver
  end
end

# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "'Dark Side' <from@example.com>"
  layout 'mailer'
end

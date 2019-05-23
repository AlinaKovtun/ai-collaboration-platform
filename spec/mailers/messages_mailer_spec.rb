# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesMailer, type: :mailer do
  describe '#contact_us_email' do
    let(:message) { build(:message).as_json }
    let(:mail) { MessagesMailer.contact_us_email(message) }
    context 'when user submitted message form' do
      it 'renders the mail body' do
        expect(mail.body.encoded).to match(message['email'])
      end
    end
  end

  describe '#approve_email' do
    let(:user) { create(:user) }
    let(:email_change_request) { create(:email_change_request) }
    let(:emailchange) { MessagesMailer.approve_email(user, email_change_request) }
    context 'when user submitted message form' do
      it 'sends approve email' do
        expect(emailchange.to.last).to match(user.email)
      end
    end
  end
end

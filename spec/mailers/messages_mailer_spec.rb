# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesMailer, type: :mailer do
  describe '#contact_us_email' do
    let(:message) { build(:message) }
    let(:mail) { MessagesMailer.contact_us_email(message) }

    context 'when user submitted message form' do
      it 'sends mail from user' do
        expect(mail.from).to eq([message.email])
      end

      it 'renders the mail body' do
        expect(mail.body.encoded).to match(message.author_name)
      end
    end
  end
end

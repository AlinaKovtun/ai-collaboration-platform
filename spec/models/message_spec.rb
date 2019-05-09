# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { build(:message) }

  describe 'Validations' do
    context 'when params is valid' do
      it 'is valid' do
        expect(message).to be_valid
      end
    end

    context 'when email is empty' do
      it 'is not valid' do
        message.email = ' '
        expect(message).not_to be_valid
      end
    end

    context 'when body is empty' do
      it 'is not valid' do
        message.body = ' '
        expect(message).not_to be_valid
      end
    end

    context 'when author name is empty' do
      it 'is not valid' do
        message.author_name = ' '
        expect(message).not_to be_valid
      end
    end
  end
end

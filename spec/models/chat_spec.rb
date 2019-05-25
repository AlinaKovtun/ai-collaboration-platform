# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chat, type: :model do
  subject { create(:chat) }

  describe 'validations' do
    context 'when all parameters are correct' do
      it 'is valid' do
        expect(build(:chat)).to be_valid
      end
    end

    context 'when body is blank' do
      it 'is invalid' do
        expect(build(:chat, body: nil)).not_to be_valid
      end
    end

    context 'when user is blank' do
      it 'is invalid without a user' do
        expect(build(:chat, user_id: nil)).not_to be_valid
      end
    end
  end
end

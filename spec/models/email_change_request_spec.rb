# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailChangeRequest, type: :model do
  describe 'Validations' do
    context 'when new_email is empty' do
      it 'is not valid' do
        expect(build(:email_change_request, email: '')).not_to be_valid
      end
    end

    context 'when new_email is invalid' do
      it 'is not valid' do
        expect(build(:email_change_request, email: 'qwe')).not_to be_valid
      end
    end

    context 'when new_email is valid' do
      it 'is valid' do
        expect(build(:email_change_request)).to be_valid
      end
    end
  end
end

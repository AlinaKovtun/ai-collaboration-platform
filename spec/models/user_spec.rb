# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations', type: :model do
    context "when user's data are correct" do
      it 'is valid' do
        expect(build(:user)).to be_valid
      end
    end

    context 'when email is not correct' do
      it 'is not valid' do
        expect(build(:user, email: '123')).not_to be_valid
      end
    end

    context 'when password is shorter than 6 characters' do
      it 'is not valid' do
        expect(build(:user, password: '123')).not_to be_valid
      end
    end

    context 'when password is longer than 128 characters' do
      it 'is not valid' do
        expect(build(:user, password: '1' * 129)).not_to be_valid
      end
    end

    context 'when first_name is blank' do
      it 'is not valid' do
        expect(build(:user, first_name: '')).not_to be_valid
      end
    end

    context 'when last_name is blank' do
      it 'is not valid' do
        expect(build(:user, last_name: '')).not_to be_valid
      end
    end

    context 'when about_me is blank' do
      it 'is valid' do
        expect(build(:user, about_me: '')).to be_valid
      end
    end

    context 'when about_me is largest than 500' do
      it 'is not valid' do
        expect(build(:user, about_me: 'd' * 501)).not_to be_valid
      end
    end
  end
end

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

    context 'when role_ids is blank' do
      it 'is valid' do
        expect(build(:user, role_ids: '')).to be_valid
      end
    end

    context 'when about_me is largest than 500' do
      it 'is not valid' do
        expect(build(:user, about_me: 'd' * 501)).not_to be_valid
      end
    end
  end

  describe 'Associations' do
    it 'has_many news' do
      association = described_class.reflect_on_association(:news)
      expect(association.macro).to eq :has_many
    end
    it 'has_and_belongs_to_many news' do
      association = described_class.reflect_on_association(:roles)
      expect(association.macro).to eq :has_and_belongs_to_many
    end
  end

  describe '#from_omniauth' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        info: {
          first_name: 'facebook name',
          last_name: 'facebook last name',
          email: 'facebook@email.com'
        }
      )
    end

    context 'when user exists' do
      let(:user) { User.from_omniauth(auth_hash) }

      it 'creates new user' do
        expect { user }.to change { User.count }.by(1)
      end

      it 'creates new user with right first_name' do
        expect(user.first_name).to eq 'facebook name'
      end

      it 'creates new user with right email' do
        expect(user.email).to eq 'facebook@email.com'
      end
    end

    context 'when user does not exist' do
      before { create(:user, email: 'facebook@email.com') }

      let(:user) { User.from_omniauth(auth_hash) }

      it 'does not create new user' do
        expect { user }.to change { User.count }.by(0)
      end

      it 'does not override present credentials of user' do
        expect(user.first_name).not_to eq 'facebook name'
      end
    end
  end
end

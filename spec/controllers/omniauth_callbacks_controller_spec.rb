# frozen_string_literal: true

require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new(
      info: {
        first_name: 'First name',
        last_name: 'Last name',
        email: 'facebook@email.com'
      }
    )
  end

  context 'when unknown user logins with facebook' do
    it 'creates new user' do
      expect { get :facebook }.to change { User.count }.by(1)
    end
  end

  context 'when registered user logins with facebook' do
    before { create(:user, email: 'facebook@email.com') }

    it 'does not create new user' do
      expect { get :facebook }.to change { User.count }.by(0)
    end
  end
end

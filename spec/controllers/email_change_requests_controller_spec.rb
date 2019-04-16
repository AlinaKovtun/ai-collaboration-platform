# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'

RSpec.describe EmailChangeRequestsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:emailchange) { create(:email_change_request) }

  before { sign_in(user) }

  describe '#create' do
    context 'correct email' do
      let(:current_password_valid) do
        { email: 'test1@ukr.net',
          current_password: user.password }
      end

      it 'create emailchange with correct password' do
        post :create, params: { email_change_request: current_password_valid }
        expect(response).to redirect_to news_index_path
      end

      let(:current_pasword_invalid) do
        { email: 'test1@ukr.net',
          current_password: '123456' }
      end

      it 'don`t create emailchange without correct password' do
        post :create, params: { email_change_request: current_pasword_invalid }
        expect(response).to render_template :new
      end
    end
  end

  describe '#approve' do
    context 'correct token' do
      it 'change user email' do
        get :approve, params: { token: emailchange.token }
        expect(flash.now[:notice]).to match('Email change')
      end
    end

    context 'uncorrect token' do
      it 'dont change user email' do
        get :approve, params: { token: '' }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe '#new' do
    it 'renders template new' do
      get :new
      expect(response).to render_template :new
    end
  end
end

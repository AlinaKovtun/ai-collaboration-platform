# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { attributes_for(:message, email: user.email) }
  let(:invalid_params) { attributes_for(:message, email: ' ') }

  before { sign_in(user) }

  describe '#contact_us' do
    it 'renders contact_us page' do
      get :contact_us
      expect(response).to render_template :contact_us
    end
  end

  describe '#create' do
    context 'when message params is right' do
      it 'sends message' do
        expect { post :create, params: { message: params } }.to \
          change { ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    context 'when message params is not right' do
      it 'does not send message' do
        expect { post :create, params: { message: invalid_params } }.to \
          change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end

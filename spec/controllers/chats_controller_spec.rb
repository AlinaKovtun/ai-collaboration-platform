# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  let(:params) { attributes_for(:chat) }
  let(:user) { create :user }
  let!(:chat) { create :chat }
  let(:invalid_params) { attributes_for(:chat, body: '') }

  before { sign_in(user) }
  headers = { 'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Content-Type' => 'application/x-www-form-urlencoded',
              'User-Agent' => 'Ruby' }

  describe '#index' do
    it 'routes /chats to chats#index' do
      expect(get: '/chatroom').to route_to(controller: 'chats', action: 'index')
    end

    it 'populates an array of chats' do
      get :index
      expect(assigns(:chats)).to eq([chat])
    end
  end

  describe '#create' do
    it 'routes /chatroom to chats#create' do
      expect(post: '/chats').to route_to(controller: 'chats', action: 'create')
    end

    context 'when params are valid' do
      it 'creates a сhat' do
        stub_request(:post, 'http://localhost:9292/faye')
          .with(body: {},
                headers: headers)
          .to_return(status: 200, body: '', headers: {})
        post :create, params: { chat: params }, xhr: true
        expect(Chat.exists?(chat.id)).to be_truthy
      end
    end

    context 'when params are invalid' do
      it 'does not create new chat in the database' do
        stub_request(:post, 'http://localhost:9292/faye')
          .with(body: {},
                headers: headers)
          .to_return(status: 200, body: '', headers: {})
        post :create, params: { id: chat.id, chat: invalid_params }, xhr: true
        expect(Chat.exists?(body: invalid_params[:body])).to be_falsy
      end
    end
  end
end

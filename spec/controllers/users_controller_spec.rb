# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'

RSpec.describe UsersController, type: :controller do
  let(:user_without_avatar) { create(:user) }

  let(:user_with_avatar) do
    create(:user, avatar: Rack::Test::UploadedFile.new(
      'spec/test3.jpeg', 'image/jpeg'
    ))
  end

  let(:correct_params) { { avatar: Rack::Test::UploadedFile.new('spec/test1.jpg', 'image/jpeg') } }

  let(:wrong_params) { { avatar: Rack::Test::UploadedFile.new('spec/test_zip.zip', 'image/jpeg') } }

  before { sign_in user_without_avatar }

  describe '#update' do
    it 'is updates avatar for user without avatar' do
      avatar_before = user_without_avatar.avatar
      put :update, params: { id: user_without_avatar.id, user: correct_params }
      user_without_avatar.reload
      expect(user_without_avatar.avatar).not_to eq(avatar_before)
    end

    it 'is updates avatar for user with avatar' do
      avatar_before = user_with_avatar.avatar
      put :update, params: { id: user_with_avatar.id, user: correct_params }
      user_with_avatar.reload
      expect(user_with_avatar.avatar).not_to eq(avatar_before)
    end

    it 'is updates avatar and rendernig show page' do
      put :update, params: { id: user_without_avatar.id, user: correct_params }
      user_without_avatar.reload
      expect(response).to render_template('show')
    end

    it 'is rendering edit page if wrong format for avatar' do
      put :update, params: { id: user_without_avatar.id, user: wrong_params }
      user_without_avatar.reload
      expect(response).to render_template('edit')
    end

    it 'is rendering show page and notice that user updated his avatar' do
      put :update, params: { id: user_with_avatar.id, user: correct_params }
      user_with_avatar.reload
      expect(flash.now[:notice]).to match('You have updated avatar')
    end

    it 'is rendering edit page and alert that user use wrong format for avatar' do
      put :update, params: { id: user_with_avatar.id, user: wrong_params }
      user_with_avatar.reload
      expect(flash.now[:alert]).to match('Wrong format')
    end
  end
end

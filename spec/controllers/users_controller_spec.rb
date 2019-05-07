# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'

RSpec.describe UsersController, type: :controller do
  let(:user_without_avatar) { create(:user) }

  let(:user_with_avatar) { create(:user, avatar: AvatarUploader.new(Rails.root.join('spec/test3.jpeg'))) }

  let(:user_with_wrong_avatar) { create(:user, avatar: AvatarUploader.new(Rails.root.join('spec/test_zip.zip'))) }

  let(:default_params) { { avatar: AvatarUploader.new(Rails.root.join('app/assets/images/default.png')) } }

  let(:correct_params) { { avatar: AvatarUploader.new(Rails.root.join('spec/test1.jpg')) } }

  let(:wrong_params) { { avatar: AvatarUploader.new(Rails.root.join('spec/test_zip.zip')) } }

  before { sign_in user_without_avatar }

  describe '#update' do
    it 'is updates avatar for user without avatar' do
      put :update, params: { id: user_without_avatar.id, user: correct_params }
      user_without_avatar.reload
      expect(response).to render_template('show')
    end

    it 'is updates avatar for user with avatar' do
      put :update, params: { id: user_with_avatar.id, user: correct_params }
      user_with_avatar.reload
      expect(user_with_avatar.avatar).not_to be_nil
    end
  end

  describe '#edit' do
    it 'is rendering edit page if wrong format for avatar' do
      put :update, params: { id: user_with_avatar.id, user: correct_params }
      user_with_avatar.reload
      expect(flash.now[:notice]).to match('You have updated avatar')
    end
    it 'is rendering edit page if wrong format for avatar' do
      put :update, params: { id: user_with_avatar.id, user: wrong_params }
      expect(flash.now[:alert]).to match('Wrong format')
    end
  end
end

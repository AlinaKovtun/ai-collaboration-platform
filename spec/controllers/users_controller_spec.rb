# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:user1) { create(:user, avatar: AvatarUploader.new(Rails.root.join('spec/test3.jpeg'))) }
  let(:params) { { avatar: AvatarUploader.new(Rails.root.join('spec/test1.jpg')) } }
  before { sign_in user }
  describe '#update' do
    it 'is updates avatar whith with default avatar' do
      put :update, params: { id: user.id, user: params }
      user.reload
      expect(response).to redirect_to(user_path(user.id))
    end

    it 'is updates avatar whith with current avatar' do
      put :update, params: { id: user1.id, user: params }
      user.reload
      expect(user.avatar).not_to be_nil
    end

    it 'is checks if user have a default avatar' do
      put :update, params: { id: user.id, user: params }
      user.reload
      expect(user.avatar).not_to be_nil
    end
  end
end

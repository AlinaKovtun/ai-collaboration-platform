# frozen_string_literal: true

require 'rails_helper'
require 'factory_bot'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:params) { { avatar: AvatarUploader.new(Rails.root.join('spec/test1.jpg')) } }
  before { sign_in user }
  describe '#update' do
    it 'updates password whith valid params' do
      put :update, params: { id: user.id, user: params }
      user.reload
      expect(response).to redirect_to(user_path(user.id))
    end
  end
end

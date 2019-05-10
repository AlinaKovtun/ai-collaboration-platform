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
    context 'correct params' do
      it 'is updates avatar for user without avatar' do
        expect do
          put :update, params: { id: user_without_avatar.id, user: correct_params }
        end.to change { user_without_avatar.reload.avatar }
      end

      it 'is updates avatar for user with avatar' do
        expect do
          put :update, params: { id: user_with_avatar.id, user: correct_params }
        end.to change { user_with_avatar.reload.avatar }
      end

      it 'renders show page' do
        put :update, params: { id: user_without_avatar.id, user: correct_params }
        user_without_avatar.reload
        expect(response).to render_template('show')
      end

      it 'is rendering show page and notice that user updated his avatar' do
        put :update, params: { id: user_with_avatar.id, user: correct_params }
        user_with_avatar.reload
        expect(flash.now[:notice]).to match('Successful update')
      end
    end

    context 'wrong params' do
      it 'rendering edit page' do
        put :update, params: { id: user_without_avatar.id, user: wrong_params }
        user_without_avatar.reload
        expect(response).to render_template('edit')
      end

      it 'is rendering edit page and alert that user use wrong format for avatar' do
        put :update, params: { id: user_with_avatar.id, user: wrong_params }
        user_with_avatar.reload
        expect(flash.now[:alert]).to match('Unsuccessful update')
      end
    end
  end
end

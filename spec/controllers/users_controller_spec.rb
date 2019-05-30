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

  let(:user) { create(:user) }

  before { sign_in(user) }

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
        expect(response).to redirect_to(user_path(user_without_avatar.id))
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

  describe '#update first_name, last_name, about_me' do
    let(:user_params_blank) do
      {
        last_name: '',
        first_name: '',
        about_me: ''
      }
    end
    it 'params blank' do
      patch :update, params: { id: user.id, user: user_params_blank }
      expect(response).to render_template :edit
    end

    let(:user_params) do
      {
        last_name: 'Abdul',
        first_name: 'Rustam',
        about_me: 'Studen'
      }
    end
    it 'params valid' do
      patch :update, params: { id: user.id, user: user_params }
      expect(response).not_to render_template :edit
    end
  end

  describe '#update_password' do
    context 'valid password' do
      before { sign_in(user) }

      let(:params1) do
        {
          password: 'wordpass1',
          password_confirmation: 'wordpass1',
          current_password: user.password
        }
      end

      it 'valid current_password' do
        patch :update_password, params: { user_id: user.id,
                                          user: params1 }
        expect(response).to redirect_to user_path(user.id)
      end

      let(:params2) do
        {
          password: 'wordpass1',
          password_confirmation: 'wordpass1',
          current_password: '123456'
        }
      end

      it 'invalid current_password' do
        patch :update_password, params: { user_id: user.id,
                                          user: params2 }
        expect(response).to render_template :edit_password
      end

      let(:params3) do
        {
          password: 'wordpass1',
          password_confirmation: 'wordpass1',
          current_password: ''
        }
      end

      it 'blank current_password' do
        patch :update_password, params: { user_id: user.id,
                                          user: params3 }
        expect(response).to render_template :edit_password
      end
    end

    let(:params_invalid) do
      {
        password: 'wordpa',
        password_confirmation: 'wordpass1',
        current_password: user.password
      }
    end

    context 'invalid password' do
      it 'valid current_password' do
        put :update_password, params: { user_id: user.id,
                                        user: params_invalid }
        expect(response).to render_template :edit_password
      end

      it 'invalid current_password' do
        put :update_password, params: { user_id: user.id,
                                        user: params_invalid }
        expect(response).to render_template :edit_password
      end

      let(:params_blank) do
        {
          password: '',
          password_confirmation: '',
          current_password: ''
        }
      end

      it 'blank current_password' do
        put :update_password, params: { user_id: user.id,
                                        user: params_blank }
        expect(response).to render_template :edit_password
      end

      let(:params_blank1) do
        {
          password: '',
          password_confirmation: '',
          current_password: user.password
        }
      end

      it 'blank password' do
        put :update_password, params: { user_id: user.id,
                                        user: params_blank1 }
        expect(response).to render_template :edit_password
      end
    end
  end

  describe '#show' do
    it 'show user' do
      get :show, params: { id: user.id }
      expect(response).to render_template :show
    end
  end

  describe '#index' do
    it 'routes /users to users#index' do
      get :index
      expect(get: '/users').to route_to(controller: 'users', action: 'index')
    end
  end

  describe '#edit' do
    context 'when users id is right' do
      it 'renders edit template' do
        get :edit, params: { id: user.id }
        expect(response).to render_template :edit
      end
    end
  end
end

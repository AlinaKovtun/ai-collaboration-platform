# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  let(:params) { attributes_for(:news, category_id: category.id) }
  let(:invalid_params) { attributes_for(:news, title: 'a' * 101) }
  let(:news) { create(:news) }
  let(:category) { create(:category) }

  before { sign_in(news.user) }

  describe '#index' do
    it 'populates an array of news' do
      get :index
      expect(assigns(:news)).to eq([news])
    end
  end

  describe '#new' do
    it 'renders template new' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#edit' do
    context 'when news id is right' do
      it 'renders edit template' do
        get :edit, params: { id: news.id }
        expect(response).to render_template :edit
      end
    end

    context 'when news id is wrong' do
      it 'does not render edit template' do
        get :edit, params: { id: news.id + 1 }
        expect(response).not_to render_template :edit
      end
    end
  end

  describe '#create' do
    context 'when params is valid' do
      it 'creates a new news' do
        post :create, params: { news: params }
        expect(News.exists?(title: params[:title])).to be true
      end

      it 'assigns flash message' do
        post :create, params: { news: params }
        expect(flash[:notice]).to eq('The News was successfully created')
      end
    end

    context 'when params is not valid' do
      it 'does not create a new news' do
        post :create, params: { news: invalid_params }
        expect(News.exists?(title: invalid_params[:title])).to be_falsy
      end
    end
  end

  describe '#show' do
    context 'when news id is right' do
      it 'renders edit page' do
        get :show, params: { id: news.id }
        expect(response).to render_template :show
      end
    end

    context 'when news id is wrong' do
      it 'does not render edit page' do
        get :show, params: { id: news.id + 1 }
        expect(response).not_to render_template :show
      end
    end

    context 'when user visits news page' do
      it 'counts views' do
        views_before = news.views
        get :show, params: { id: news.id }
        news.reload
        expect(news.views).to eq views_before + 1
      end
    end
  end

  describe '#update' do
    context 'when params is valid' do
      it 'updates body' do
        put :update, params: { id: news.id, news: params }
        news.reload
        expect(news.title).to eq params[:title]
      end
    end

    context 'when params is not valid' do
      it 'does not update body' do
        params[:title] = ''
        put :update, params: { id: news.id, news: params }
        news.reload
        expect(news.title).not_to eq params[:title]
      end
    end
  end

  describe '#destroy' do
    context 'when news id is right' do
      it 'deletes news' do
        delete :destroy, params: { id: news.id }
        expect(News.exists?(news.id)).to be_falsy
      end
    end

    context 'when news id is wrong' do
      it 'does not delete news' do
        delete :destroy, params: { id: news.id + 1 }
        expect(response.status).to eq(404)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:params) { attributes_for(:category) }
  let(:user) { create :user }
  let!(:category) { create :category }
  let(:invalid_params) { attributes_for(:category, name: '') }

  before { sign_in(user) }

  describe '#index' do
    it 'routes /categories to categories#index' do
      expect(get: '/categories').to route_to(controller: 'categories', action: 'index')
    end

    it 'populates an array of categories' do
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe '#show' do
    it 'routes /categories/1 to categories#show' do
      expect(get: '/categories/1').to route_to(controller: 'categories', action: 'show', id: '1')
    end

    context 'when category id is valid' do
      it 'renders edit page' do
        get :show, params: { id: category.id }
        expect(response).to render_template :show
      end
    end

    context 'when category id is invalid' do
      it 'does not render edit page' do
        get :show, params: { id: category.id + 1 }
        expect(response).not_to render_template :show
      end
    end
  end

  describe '#new' do
    it 'routes /categories/new to categories#new' do
      expect(get: '/categories/new').to route_to(controller: 'categories', action: 'new')
    end

    it 'assigns a new category to @category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe '#create' do
    it 'routes /categories to categories#create' do
      expect(post: '/categories').to route_to(controller: 'categories', action: 'create')
    end

    it 'redirects to categories#show' do
      post :create, params: { category: params }
      expect(response).to redirect_to(categories_path)
    end

    context 'when params are valid' do
      it 'creates a category' do
        post :create, params: { category: params }
        expect(Category.exists?(category.id)).to be_truthy
      end
    end

    context 'when params are invalid' do
      it 'does not create new category in the database' do
        post :create, params: { id: category.id, category: invalid_params }
        expect(Category.exists?(name: invalid_params[:name])).to be_falsy
      end
    end
  end

  describe '#edit' do
    it 'routes /categories/1/edit to categories#edit' do
      expect(get: '/categories/1/edit').to route_to(controller: 'categories',
                                                    action: 'edit', id: '1')
    end

    context 'when category id is correct' do
      it 'renders edit template' do
        get :edit, params: { id: category.id }
        expect(response).to render_template :edit
      end
    end

    context 'when category id is incorrect' do
      it 'does not render edit template' do
        get :edit, params: { id: category.id + 1 }
        expect(response).not_to render_template :edit
      end
    end
  end

  describe '#update' do
    it 'routes /categories/1 to categories#update' do
      expect(put: '/categories/1').to route_to(controller: 'categories', action: 'update', id: '1')
    end

    context 'when params are valid' do
      it 'updates category' do
        put :update, params: { id: category.id, category: params }
        category.reload
        expect(category.name).to eq params[:name]
      end
    end

    context 'when params are invalid' do
      it 'renders :edit template' do
        put :update, params: { id: category.id, category: invalid_params }
        expect(response).to render_template(:edit)
      end

      it 'does not update category in the database' do
        put :update, params: { id: category.id, category: invalid_params }
        category.reload
        expect(category.description).not_to eq('new')
      end
    end
  end

  describe '#destroy' do
    it 'routes /categories/1 to categories#destroy' do
      expect(delete: '/categories/1').to route_to(controller: 'categories',
                                                  action: 'destroy', id: '1')
    end
    context 'when id is correct' do
      it 'deletes categories from database' do
        delete :destroy, params: { id: category.id }
        expect(Category.exists?(category.id)).to be_falsy
      end
    end

    context 'when id is incorrect' do
      it 'does not delete category' do
        delete :destroy, params: { id: category.id + 1 }
        expect(response.status).to eq(404)
      end
    end
  end
end

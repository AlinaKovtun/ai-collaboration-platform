# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:project) { create(:project) }
  let(:params) { attributes_for(:project) }
  let(:invalid_params) { attributes_for(:project, name: 'a' * 120) }

  before { sign_in(project.author) }

  describe '#index' do
    it 'populates an array of projects' do
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe '#new' do
    it 'renders template new' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe '#edit' do
    context 'when project id is right' do
      it 'renders edit template' do
        get :edit, params: { id: project.id }
        expect(response).to render_template :edit
      end
    end

    context 'when project id is wrong' do
      it 'does not render edit template' do
        get :edit, params: { id: project.id + 1 }
        expect(response).not_to render_template :edit
      end
    end
  end

  describe '#create' do
    context 'when params is valid' do
      it 'creates a new project' do
        post :create, params: { project: params }
        expect(Project.exists?(name: params[:name])).to be true
      end

      it 'assigns flash message' do
        post :create, params: { project: params }
        expect(flash[:notice]).to eq('Project successfully created')
      end
    end

    context 'when params is not valid' do
      it 'does not create a new project' do
        post :create, params: { project: invalid_params }
        expect(Project.exists?(name: invalid_params[:name])).to be_falsy
      end
    end
  end

  describe '#show' do
    context 'when project id is right' do
      it 'renders edit page' do
        get :show, params: { id: project.id }
        expect(response).to render_template :show
      end
    end

    context 'when project id is wrong' do
      it 'does not render show page' do
        get :show, params: { id: project.id + 1 }
        expect(response).not_to render_template :show
      end
    end
  end

  describe '#update' do
    context 'when params is valid' do
      it 'updates name' do
        put :update, params: { id: project.id, project: params }
        project.reload
        expect(project.name).to eq params[:name]
      end
    end

    context 'when params is not valid' do
      it 'does not update name' do
        params[:name] = ''
        put :update, params: { id: project.id, project: params }
        project.reload
        expect(project.name).not_to eq params[:name]
      end
    end
  end

  describe '#destroy' do
    context 'when project id is right' do
      it 'deletes projects' do
        delete :destroy, params: { id: project.id }
        expect(Project.exists?(project.id)).to be_falsy
      end
    end

    context 'when project id is wrong' do
      it 'does not delete project' do
        delete :destroy, params: { id: project.id + 1 }
        expect(response.status).to eq(404)
      end
    end
  end
end

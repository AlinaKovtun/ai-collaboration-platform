
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) {create(:project) }
  let(:tasks) { create(:task) }
  let(:params) { attributes_for(:task) }
  let(:invalid_params) { attributes_for(:task, title: 'a' * 201) }

  before { sign_in(user) }

  describe '#index' do
    it 'routes /events to events#index' do
      expect(get: '/project/1').to route_to(controller: 'project', action: 'index')
    end
     it 'create an array of precent tasks' do
      get :index
      expect(assigns(:tasks)).to eq([tasks])
    end
  end

  describe '#new' do
    it 'routes /tasks/new to tasks#new' do
      expect(get: '/tasks/new').to route_to(controller: 'tasks', action: 'new')
    end

    it 'assigns a new task' do
      get :new
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'returns HTTP status ok (200)' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'routes /tasks to task#create' do
      expect(post: '/tasks').to route_to(controller: 'tasks', action: 'create')
    end

    it 'redirects to tasks#index' do
      post :create, params: { task: params }
      expect(response).to redirect_to(tasks_path)
    end

    it 'returns HTTP status found' do
      post :create, params: { task: params }
      expect(response).to have_http_status(:found)
    end

    context 'when params are valid' do
      it 'creates a task' do
        post :create, params: { task: params }
        expect(Task.exists?(title: params[:title])).to be_truthy
      end
    end
    context 'when params are invalid' do
      it 'does not create new tasks in the database' do
        post :create, params: { task: invalid_params }
        expect(Task.exists?(title: invalid_params[:title])).to be_falsy
      end
    end
  end

  describe '#edit' do
    it 'routes /taskss/1/edit to taskss#edit' do
      expect(get: '/tasks/1/edit').to route_to(controller: 'tasks',
                                                action: 'edit', id: '1')
    end
    context 'when task id is correct' do
      it 'renders edit template' do
        get :edit, params: { id: tasks.id }
        expect(response).to render_template :edit
      end

      it 'returns HTTP status ok' do
        get :edit, params: { id: tasks.id }
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when task id is incorrect' do
      it 'does not render edit template' do
        get :edit, params: { id: tasks.id + 1 }
        expect(response).not_to render_template :edit
      end

      it 'returns HTTP status not found' do
        get :edit, params: { id: tasks.id + 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#update' do
    it 'routes /tasks/1 to tasks#update' do
      expect(put: '/tasks/1').to route_to(controller: 'tasks', action: 'update', id: '1')
    end

    context 'when params are valid' do
      it 'updates task' do
        put :update, params: { id: tasks.id, task: params }
        tasks.reload
        expect(tasks.title).to eq params[:title]
      end

      it 'returns HTTP status found' do
        put :update, params: { id: tasks.id, task: params }
        tasks.reload
        expect(response).to have_http_status(:found)
      end
    end

    context 'when params are invalid' do
      it 'renders :edit template' do
        put :update, params: { id: tasks.id, task: invalid_params }
        expect(response).to render_template(:edit)
      end

      it 'returns HTTP status ok' do
        put :update, params: { id: tasks.id, task: invalid_params }
        expect(response).to have_http_status(:ok)
      end

      it 'does not update task in the database' do
        put :update, params: { id: tasks.id, task: invalid_params }
        tasks.reload
        expect(tasks.short_information).not_to eq('new')
      end
    end
  end

  describe '#destroy' do
    it 'routes /tasks/1 to tasks#destroy' do
      expect(delete: '/tasks/1').to route_to(controller: 'tasks',
                                              action: 'destroy', id: '1')
    end

    context 'when id is correct' do
      it 'deletes task from database' do
        delete :destroy, params: { id: tasks.id }
        expect(Task.exists?(tasks.id)).to be_falsy
      end
    end

    context 'when id is incorrect' do
      it 'does not delete task' do
        delete :destroy, params: { id: tasks.id + 10 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

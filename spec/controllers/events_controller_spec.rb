# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:params) { attributes_for(:event) }
  let(:invalid_params) { attributes_for(:event, title: 'a' * 201) }
  let(:event) { create(:event) }

  before { sign_in(event.user) }

  describe '#index' do
    let(:event) { create(:event, :sheduled) }
    it 'routes /events to events#index' do
      expect(get: '/events').to route_to(controller: 'events', action: 'index')
    end

    it 'create an array of precent events' do
      get :index
      expect(assigns(:events)).to eq([event])
    end
  end

  describe '#show' do
    it 'routes /events/1 to events#show' do
      expect(get: '/events/1').to route_to(controller: 'events', action: 'show', id: '1')
    end

    context 'when event id is valid' do
      it 'renders show page' do
        get :show, params: { id: event.id }
        expect(response).to render_template :show
      end

      it 'returns HTTP status ok (200)' do
        get :show, params: { id: event.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when category id is invalid' do
      it 'does not render show page' do
        get :show, params: { id: event.id + 1 }
        expect(response).not_to render_template :show
      end

      it 'returns HTTP status not found' do
        get :show, params: { id: event.id + 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#new' do
    it 'routes /events/new to events#new' do
      expect(get: '/events/new').to route_to(controller: 'events', action: 'new')
    end

    it 'assigns a new event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'returns HTTP status ok (200)' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    it 'routes /events to events#create' do
      expect(post: '/events').to route_to(controller: 'events', action: 'create')
    end

    it 'redirects to evetns#show' do
      post :create, params: { event: params }
      expect(response).to redirect_to(events_path)
    end

    it 'returns HTTP status found' do
      post :create, params: { event: params }
      expect(response).to have_http_status(:found)
    end

    context 'when params are valid' do
      it 'creates a event' do
        post :create, params: { event: params }
        expect(Event.exists?(title: params[:title])).to be_truthy
      end
    end

    context 'when params are invalid' do
      it 'does not create new event in the database' do
        post :create, params: { event: invalid_params }
        expect(Event.exists?(title: invalid_params[:title])).to be_falsy
      end
    end
  end

  describe '#edit' do
    it 'routes /events/1/edit to events#edit' do
      expect(get: '/events/1/edit').to route_to(controller: 'events',
                                                action: 'edit', id: '1')
    end

    context 'when event id is correct' do
      it 'renders edit template' do
        get :edit, params: { id: event.id }
        expect(response).to render_template :edit
      end

      it 'returns HTTP status ok' do
        get :edit, params: { id: event.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when event id is incorrect' do
      it 'does not render edit template' do
        get :edit, params: { id: event.id + 1 }
        expect(response).not_to render_template :edit
      end

      it 'returns HTTP status not found' do
        get :edit, params: { id: event.id + 1 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when current user doesn't create an event" do
      it 'returns HTTP status not found' do
        sign_in(create(:user))
        get :edit, params: { id: event.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#update' do
    it 'routes /evnts/1 to events#update' do
      expect(put: '/events/1').to route_to(controller: 'events', action: 'update', id: '1')
    end

    context 'when params are valid' do
      it 'updates event' do
        put :update, params: { id: event.id, event: params }
        event.reload
        expect(event.title).to eq params[:title]
      end

      it 'returns HTTP status found' do
        put :update, params: { id: event.id, event: params }
        event.reload
        expect(response).to have_http_status(:found)
      end
    end

    context 'when params are invalid' do
      it 'renders :edit template' do
        put :update, params: { id: event.id, event: invalid_params }
        expect(response).to render_template(:edit)
      end

      it 'returns HTTP status ok' do
        put :update, params: { id: event.id, event: invalid_params }
        expect(response).to have_http_status(:ok)
      end

      it 'does not update event in the database' do
        put :update, params: { id: event.id, event: invalid_params }
        event.reload
        expect(event.description).not_to eq('new')
      end
    end

    context "when current user doesn't create an event" do
      it 'returns HTTP status not found' do
        sign_in(create(:user))
        put :update, params: { id: event.id, event: params }
        event.reload
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#destroy' do
    it 'routes /events/1 to events#destroy' do
      expect(delete: '/events/1').to route_to(controller: 'events',
                                              action: 'destroy', id: '1')
    end
    context 'when id is correct' do
      it 'deletes event from database' do
        event.archive
        delete :destroy, params: { id: event.id }
        expect(Event.exists?(event.id)).to be_truthy
        expect(event).to have_state(:archived)
      end
    end

    context 'when id is incorrect' do
      it 'does not delete event' do
        delete :destroy, params: { id: event.id + 10 }
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when current user doesn't create an event" do
      it 'returns HTTP status not found' do
        sign_in(create(:user))
        delete :destroy, params: { id: event.id }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

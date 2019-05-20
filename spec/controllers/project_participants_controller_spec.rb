# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectParticipantsController, type: :controller do
  let(:role) { create(:role) }
  let(:user) { create(:user) }
  let(:project) { create(:project) }
  let(:project_participant) { create(:project_participant) }
  let(:params) { { role_id: role.id, user_id: user.id, project_id: project.id } }

  before { sign_in(project.author) }

  describe '#create' do
    let(:request) do
      post :create, params: { project_id: project.id, project_participant: params }, format: :js
    end

    context 'when such participant does not exist on project' do
      it 'creates a new project participant' do
        expect { request }.to change { ProjectParticipant.count }.by(1)
      end
    end

    context 'when such participant exists on project' do
      it 'does not create a new project participant' do
        create(:project_participant, params)
        expect { request }.to change { ProjectParticipant.count }.by(0)
      end
    end
  end

  describe '#destroy' do
    context 'when project participant id is right' do
      it 'deletes projects' do
        delete :destroy, params: { project_id: project.id, id: project_participant.id }, format: :js
        expect(ProjectParticipant.exists?(project.id)).to be_falsy
      end
    end

    context 'when  project participant id is wrong' do
      it 'does not delete project' do
        delete :destroy, params: { project_id: project.id, id: project_participant.id + 1 }, \
                         format: :js
        expect(response.status).to eq(404)
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectParticipant, type: :model do
  describe 'Validations' do
    context 'when such participant does not exist in project' do
      it 'is valid' do
        project_participant = create(:project_participant)
        expect(project_participant).to be_valid
      end
    end

    context 'when such participant exists in project' do
      it 'is not valid' do
        project_participant = create(:project_participant)
        expect(project_participant.dup).not_to be_valid
      end
    end
  end

  describe 'Associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs to role' do
      association = described_class.reflect_on_association(:role).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs to project' do
      association = described_class.reflect_on_association(:project).macro
      expect(association).to eq :belongs_to
    end
  end
end

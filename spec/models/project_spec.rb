# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'Validations' do
    context 'when name is empty' do
      it 'is not valid' do
        project.name = ' '
        expect(project).not_to be_valid
      end
    end

    context 'when name is too big' do
      it 'is not valid' do
        project.name = 'a' * 120
        expect(project).not_to be_valid
      end
    end

    context 'when description is empty' do
      it 'is not valid' do
        project.description = ' '
        expect(project).not_to be_valid
      end
    end
  end

  describe 'Associations' do
    it 'has many participants' do
      association = described_class.reflect_on_association(:project_participants).macro
      expect(association).to eq :has_many
    end

    it 'has many users through project participants' do
      have_many(:users).through(:project_participants)
    end
  end
end

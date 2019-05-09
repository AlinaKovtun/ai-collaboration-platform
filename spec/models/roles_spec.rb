# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'Associations' do
    it 'has_and_belongs_to_many news' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_and_belongs_to_many
    end
  end

  describe 'Validations' do
    context 'when name is not unique' do
      it { should validate_uniqueness_of(:name) }
    end
  end

  describe 'Scope' do
    it 'should not include admin role' do
      expect(Role.visible_to_users).to_not include(Role.where(name: 'admin'))
    end
  end
end

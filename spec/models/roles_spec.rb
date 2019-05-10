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
    before { create(:admin_role) }
    before { create(:student_role) }

    it 'should not include admin role' do
      expect(Role.visible_to_users).not_to include(Role.find_by_name('admin'))
    end
  end
end

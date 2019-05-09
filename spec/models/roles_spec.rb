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
    before { %w[admin student menthor].each { |r| create(:role, name: r) } }
    it 'should return 2 roles' do
      r = Role.visible_to_users
      expect(r.count).to eq(2)
    end
  end
end

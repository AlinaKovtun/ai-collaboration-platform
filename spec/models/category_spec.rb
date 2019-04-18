# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { create(:category) }

  describe 'validations' do
    context 'when name is not unique' do
      it { should validate_uniqueness_of(:name) }
    end

    context 'when all parameters are correct' do
      it 'is valid' do
        expect(build(:category)).to be_valid
      end
    end

    context 'when name is blank' do
      it 'is invalid' do
        expect(build(:category, name: nil)).not_to be_valid
      end
    end

    context 'when description is blank' do
      it 'is invalid without a description' do
        expect(build(:category, description: nil)).not_to be_valid
      end
    end
  end
end

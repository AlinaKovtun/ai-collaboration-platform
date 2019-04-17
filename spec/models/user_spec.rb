# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context "when user's data are correct" do
    it 'is valid' do
      expect(build(:user)).to be_valid
    end
  end

  context "when user's data are not correct" do
    it 'is not valid' do
      expect(build(:user, password: '123')).not_to be_valid
    end
  end

  describe 'validations', type: :model do
    context 'when first_name and last_name are blank' do
      it 'is not valid' do
        expect(build(:user, first_name: '', last_name: '')).not_to be_valid
      end
    end

    context 'when description is blank' do
      it 'is valid' do
        expect(build(:user, description: '')).to be_valid
      end
    end

    context 'when description is largest than 500' do
      it 'is not valid' do
        descript = 'd' * 501
        expect(build(:user, description: descript)).not_to be_valid
      end
    end
  end
end

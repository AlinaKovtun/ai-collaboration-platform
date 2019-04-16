# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'create' do
    it 'is valid' do
      expect(build(:user)).to be_valid
    end
    it 'is not valid' do
      expect(build(:user, password: '123')).not_to be_valid
    end
  end

  context 'first_name and last_name are blank' do
    it 'User is not valid' do
      expect(build(:user, first_name: '')).not_to be_valid
      expect(build(:user, first_name: '', last_name: '')).not_to be_valid
    end
  end

  context 'description is largest than 500' do
    it 'User is not valid' do
      descript = 'd' * 501
      expect(build(:user, description: descript)).not_to be_valid
    end
  end
end

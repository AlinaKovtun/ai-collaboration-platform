# frozen_string_literal: true

require 'rails_helper'

RSpec.describe News, type: :model do
  let(:news) { build(:news) }

  describe 'Validations' do
    context 'when title is empty' do
      it 'is not valid' do
        news.title = ' '
        expect(news).not_to be_valid
      end
    end

    context 'when title is too big' do
      it 'is not valid' do
        news.title = 'a' * 120
        expect(news).not_to be_valid
      end
    end

    context 'when body is empty' do
      it 'is not valid' do
        news.title = ' '
        expect(news).not_to be_valid
      end
    end

    context 'when short_information is empty' do
      it 'is not valid' do
        news.short_information = ' '
        expect(news).not_to be_valid
      end
    end

    context 'when short_information is too big' do
      it 'is not valid' do
        news.short_information = 'a' * 250
        expect(news).not_to be_valid
      end
    end
  end

  describe 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end
end

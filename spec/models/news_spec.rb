# frozen_string_literal: true

require 'rails_helper'

RSpec.describe News, type: :model do
  let(:news) { create(:news, :draft) }

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

  describe 'State Machine' do
    it 'should move through the steps of the state machine properly' do
      expect(news).to have_state(:draft)
      expect(news).to allow_event :publish
      expect(news).to allow_event :reject
      expect(news).to transition_from(:draft).to(:published).on_event(:publish)
      expect(news).to have_state(:published)
      expect(news).to allow_event :unpublish
      expect(news).to allow_event :archive
      expect(news).to transition_from(:published).to(:archived).on_event(:archive)
      expect(news).to have_state(:archived)
    end
  end
end

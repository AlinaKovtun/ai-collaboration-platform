# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { build(:event) }

  describe 'validations' do
    context "when title's data are correct" do
      it 'is valid' do
        expect(event).to be_valid
      end
    end

    context 'when title is empty' do
      it 'is not valid' do
        event.title = ' '
        expect(event).not_to be_valid
      end
    end

    context 'when title is too long' do
      it 'is not valid' do
        event.title = 't' * 201
        expect(event).not_to be_valid
      end
    end

    context 'when description is empty' do
      it 'is not valid' do
        event.description = ' '
        expect(event).not_to be_valid
      end
    end

    context 'when venue is empty' do
      it 'is not valid' do
        event.venue = ' '
        expect(event).not_to be_valid
      end
    end

    context 'when event_start is empty' do
      it 'is not valid' do
        event.event_start = ' '
        expect(event).not_to be_valid
      end
    end

    context 'when event_end is empty' do
      it 'is not valid' do
        event.event_end = ' '
        expect(event).not_to be_valid
      end
    end

    context 'when event_start is past date and time' do
      it 'is not valid' do
        event.event_start = Time.now - 1.week
        expect(event).not_to be_valid
      end
    end

    context 'when event_end is past date and time' do
      it 'is not valid' do
        event.event_end = Time.now - 1.week
        expect(event).not_to be_valid
      end
    end

    context 'when event_end is less than event_start' do
      it 'is not valid' do
        event.event_end = Time.now - 1.week
        expect(event).not_to be_valid
      end
    end

    context 'when cost is empty' do
      it 'is not valid' do
        event.cost = nil
        expect(event).not_to be_valid
      end
    end

    context 'when cost is negative' do
      it 'is not valid' do
        event.cost = -1
        expect(event).not_to be_valid
      end
    end

    context 'when cost is positive' do
      it 'is not valid' do
        event.cost = 150
        expect(event).to be_valid
      end
    end
  end

  describe 'associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end
end

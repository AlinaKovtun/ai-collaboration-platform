# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { build(:comment) }
  let(:commented_comment) { create(:comment) }
  let(:news) { create(:news) }

  describe 'Validations' do
    context 'when content field is not empty' do
      it 'would be valid' do
        comment.commentable_id = news.id
        expect(comment).to be_valid
      end
    end

    context 'when content field is empty' do
      it 'would not be valid false' do
        comment.content = ''
        expect(comment).to be_invalid
      end
    end
  end

  describe 'Associations' do
    context 'when comment to news is created' do
      it 'belongs to commentable' do
        comment.commentable = news
        expect(comment).to belong_to(:commentable)
      end

      it 'belongs to user' do
        expect(comment).to belong_to(:user)
      end
    end

    context 'when comment to comment is created' do
      it 'belongs to commentable' do
        comment.commentable = commented_comment
        expect(comment).to belong_to(:commentable)
      end

      it 'belongs to user' do
        expect(comment).to belong_to(:user)
      end
    end
  end
end

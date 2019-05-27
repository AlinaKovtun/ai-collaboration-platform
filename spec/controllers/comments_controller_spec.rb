# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:params) { attributes_for(:comment) }
  let(:invalid_params) { attributes_for(:comment, content: '') }
  let(:news) { create(:news) }
  let(:comment) { create(:comment) }
  let(:user) { news.user }
  before { sign_in(user) }

  describe '#create' do
    context 'when create comment to news' do
      context 'when params is valid' do
        it 'creates a new comment' do
          post :create, params: { comment: params, news_id: news.id }
          expect(Comment.exists?(content: params[:content])).to be_truthy
        end

        it 'sends email' do
          expect { post :create, params: { comment: params, news_id: news.id } }.to \
            change { enqueued_jobs.size }.by(1)
        end
      end

      context 'when params is not valid' do
        it 'does not create a new comment' do
          post :create, params: { comment: invalid_params, news_id: news.id }
          expect(Comment.exists?(content: invalid_params[:content])).to be_falsy
        end

        it 'does not send email' do
          expect { post :create, params: { comment: invalid_params, news_id: news.id } }.to \
            change { enqueued_jobs.size }.by(0)
        end
      end
    end

    context 'when create comment to comment' do
      context 'when params is valid' do
        it 'creates a new comment' do
          post :create, params: { comment: params, comment_id: comment.id, news_id: news.id }
          expect(Comment.exists?(content: params[:content])).to be_truthy
        end
      end

      context 'when params is not valid' do
        it 'does not create a new comment' do
          post :create, params: { comment: invalid_params,
                                  comment_id: comment.id,
                                  news_id: news.id }
          expect(Comment.exists?(content: invalid_params[:content])).to be_falsy
        end
      end
    end
  end

  describe '#destroy' do
    context 'when comment id is right' do
      let!(:comment1) { create(:comment, commentable: comment, user_id: user.id) }
      let!(:reply_comment) { create(:comment, commentable: comment1, user_id: user.id) }

      context 'when delete reply comment' do
        it 'deletes comment' do
          delete :destroy, params: { id: reply_comment.id, news_id: news.id }
          expect(Comment.exists?(reply_comment.id)).to be_falsy
        end
      end

      context 'when delete ancestor comment' do
        it 'deletes ancestor comment and child' do
          delete :destroy, params: { id: comment1.id, news_id: news.id }
          expect(Comment.exists?(comment1.id)).to be_falsy
          expect(Comment.exists?(reply_comment.id)).to be_falsy
        end
      end

      context 'when delete another user comment' do
        it 'fails' do
          sign_in(create(:user))
          delete :destroy, params: { id: comment.id, news_id: news.id }
          expect(response).to have_http_status(:not_found)
        end

        it 'would not be destroyed' do
          sign_in(create(:user))
          delete :destroy, params: { id: comment.id, news_id: news.id }
          expect(Comment.exists?(comment.id)).to be_truthy
        end
      end
    end
  end
end

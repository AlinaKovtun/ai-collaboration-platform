# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_commentable, only: %i[create]
  before_action :find_current_user_comments, only: %i[edit update destroy]

  def create
    @commentable.comments.build(comment_params.merge(user_id: current_user.id))
    if @commentable.save
      flash[:notice] = t('.notice')
      send_email
    else
      flash[:alert] = t('.alert')
    end

    redirect_back(fallback_location: root_path)
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    if @comment.destroy
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find(params[:comment_id])
    elsif params[:news_id]
      @commentable = News.find(params[:news_id])
    end
  end

  def find_current_user_comments
    @comment = current_user.comments.find(params[:id])
  end

  def send_email
    url = news_url(params[:news_id])
    MessagesMailer.comment_email(@commentable, current_user, url).deliver_later
  end
end

# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :find_current_user_news, only: %i[edit update destroy]

  def index
    @news = News.all
  end

  def show
    @news = News.find(params[:id])
    @news.update_column(:views, @news.views + 1)
  end

  def new
    @news = News.new
  end

  def edit; end

  def create
    @news = current_user.news.build(news_params)

    if @news.save
      redirect_to news_index_path, notice: t('.notice')
    else
      render 'new', alert: t('.alert')
    end
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: t('.notice')
    else
      render 'edit', alert: t('.alert')
    end
  end

  def destroy
    if @news.destroy
      redirect_to news_index_path, notice: t('.notice')
    else
      redirect_to news_index_path, alert: t('.alert')
    end
  end

  private

  def news_params
    params.require(:news).permit(:title, :short_information, :body)
  end

  def find_current_user_news
    @news = current_user.news.find(params[:id])
  end
end

# frozen_string_literal: true

class NewsController < ApplicationController
  before_action :find_current_user_news, only: %i[edit update destroy]

  has_scope :ordered_by_views, type: :boolean, only: %i[index]
  has_scope :by_categories, type: :array, only: %i[index]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @categories = Category.all
    search = params[:title_search]
    @news = apply_scopes(News).ordered.search(search).paginate(page: params[:page], per_page: 3)
    flash.now[:alert] = t('.alert') if @news.empty?
    respond_to :js, :html
  end

  def show
    @news = News.find(params[:id])
    @news.increment!(:views)
    @comments = @news.comments.sort_by(&:created_at)
    @comment = Comment.new
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

  def user_news
    @user = User.find(params[:id])
    @news = News.where(user_id: params[:id]).paginate(page: params[:page], per_page: 5)
  end

  private

  def news_params
    params.require(:news).permit(:title, :short_information, :body, :image, :category_id)
  end

  def find_current_user_news
    @news = current_user.news.find(params[:id])
  end
end

# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: t('.notice')
    else
      render 'new', alert: t('.alert')
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: t('.notice')
    else
      redirect_to root_path, alert: t('.alert')
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: t('.notice')
    else
      render 'edit', alert: t('.alert')
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end

# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: %i[edit update destroy]
  before_action :authorize_category, only: %i[edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new

    authorize @category
  end

  def create
    @category = Category.new(category_params)

    authorize @category

    if @category.save
      redirect_to root_path, notice: I18n.t('categories.notice.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to root_path, notice: I18n.t('categories.notice.success')
    else
      render :edit, notice: I18n.t('categories.notice.error')
    end
  end

  def destroy
    @category.destroy

    redirect_to root_path, notice: I18n.t('categories.notice.delete')
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def authorize_category
    authorize @category
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end

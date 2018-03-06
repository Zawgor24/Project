# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: %i[edit update destroy]
  before_action :authorize_category, only: %i[edit update destroy]

  def new
    @category = Category.new

    authorize @category
  end

  def create
    @category = Category.new(category_params)

    authorize @category

    if @category.save
      redirect_to root_path, success: t('notices.success', name: @category.name)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to root_path, success: t('notices.update', name: @category.name)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    @category.destroy

    redirect_to root_path, danger: t('notices.delete', name: @category.name)
  end

  private

  def find_category
    @category = Category.find_by(id: params[:id])
  end

  def authorize_category
    authorize @category
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end

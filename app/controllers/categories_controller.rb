# frozen_string_literal: true

class CategoriesController < ApplicationController
  expose :category

  before_action :authorize_category

  def create
    if category.save
      redirect_to root_path, success: t('notices.success', name: category.name)
    else
      render :new, warning: t('notices.error')
    end
  end

  def update
    if category.update(category_params)
      redirect_to root_path, success: t('notices.update', name: category.name)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    category.destroy

    redirect_to root_path, danger: t('notices.delete', name: category.name)
  end

  private

  def authorize_category
    authorize category
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end

# frozen_string_literal: true

class ArticlesController < ApplicationController
  expose :article
  expose :articles, -> { Article.order(updated_at: :desc) }
  expose :comments, -> { article.comments.includes(:user) }
  expose :sports,   -> { Sport.order(name: :asc) }

  before_action :authorize_article, except: %i[index show]
  before_action :set_categories, only: :index

  def index; end

  def show; end

  def create
    article = current_user.articles.new(article_params)

    if article.save
      redirect_to root_path, success: t('notices.success', name: article.title)
    else
      render :new, warning: t('notices.error')
    end
  end

  def update
    if article.update(article_params)
      redirect_to article, success: t('notices.update', name: article.title)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    article.destroy

    redirect_to root_path, danger: t('notices.delete', name: article.title)
  end

  private

  def authorize_article
    authorize article
  end

  def article_params
    params.require(:article).permit(:title, :body, :avatar)
  end
end

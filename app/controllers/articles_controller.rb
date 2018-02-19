# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :find_article, only: %i[show edit update destroy]
  before_action :authorize_article, only: %i[edit update destroy]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    @article = Article.new

    authorize @article
  end

  def create
    @article = current_user.articles.new(article_params)

    authorize @article

    if @article.save
      redirect_to root_path, success: t('notices.success', name: @article.title)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, success: t('notices.update', name: @article.title)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, danger: t('notices.delete', name: @article.title)
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end

  def authorize_article
    authorize @article
  end

  def article_params
    params.require(:article).permit(:title, :body, :avatar)
  end
end

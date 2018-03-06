# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_category, only: :index
  before_action :find_post, only: %i[show edit update destroy]
  before_action :authorize_post, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index show]

  def index
    @posts = Post.by_subtree_categories(@category.subtree_ids)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, success: t('notices.success', name: @post.title)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('notices.update', name: @post.title)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, danger: t('notices.delete', name: @post.title)
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def authorize_post
    authorize @post
  end

  def set_categories
    @categories = Category.order(name: :asc)
  end

  def find_category
    @category ||= Category.find(params[:category_id])
  end

  def post_params
    params.require(:post).permit(:avatar, :body, :category_id, :title)
  end
end

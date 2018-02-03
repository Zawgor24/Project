# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_category, only: :index
  before_action :find_post, only: %i[show edit update destroy]

  def index
    @posts = Post.where(category_id: @category.subtree_ids).order(
      updated_at: :desc
    )
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: I18n.t('posts.notice.success')
    else
      render :new, notice: I18n.t('posts.notice.error')
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, I18n.t('posts.notice.delete')
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def find_category
    @category ||= Category.find(params[:category_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :avatar, :category_id)
  end
end

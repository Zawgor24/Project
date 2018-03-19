# frozen_string_literal: true

class PostsController < ApplicationController
  expose :post
  expose :category, id: :category_id
  expose :comments, -> { post.comments.includes(:user) }
  expose :posts,    lambda {
    Post.by_subtree_category(category.subtree_ids).paginate(page: params[:page])
  }

  before_action :authorize_post, only: %i[edit update destroy]
  before_action :set_categories, only: %i[index show]

  def index; end

  def show; end

  def create
    post = current_user.posts.new(post_params)

    if post.save
      redirect_to post, success: t('notices.success', name: post.title)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if post.update(post_params)
      redirect_to post, success: t('notices.update', name: post.title)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    post.destroy

    redirect_to root_path, danger: t('notices.delete', name: post.title)
  end

  private

  def authorize_post
    authorize post
  end

  def post_params
    params.require(:post).permit(:avatar, :body, :category_id, :title)
  end
end

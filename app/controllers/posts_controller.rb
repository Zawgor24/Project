# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show edit update destroy]

  def index
    @posts = Post.where(category_id: find_category)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
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

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def find_category
    Category.find(params[:category_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :avatar, :category_id)
  end
end

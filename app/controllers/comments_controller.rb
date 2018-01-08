# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[edit update destroy]
  before_action :find_commentable, only: %i[create update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params_with_user)
    if @comments.save
      redirect_to @commentable
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @commentable
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to @commentable
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_commentable
    @commentable = Article.find(params[:article_id]) if params[:article_id]
    @commentable = Post.find(params[:post_id]) if params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

  def comment_params_with_user
    comment_params.merge(user_id: current_user.id)
  end
end

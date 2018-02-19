# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[edit update destroy]
  before_action :authorize_comment, only: %i[edit update destroy]

  before_action :commentable_article, only: :create
  before_action :commentable_post, only: :create
  before_action :commentable_invit_post, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params_with_user)

    if @comment.save
      redirect_to request.referer,
        success: t('notices.success', name: @comment.title)
    else
      redirect_to request.referer, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable,
        success: t('notices.update', name: @comment.title)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    @comment.destroy

    redirect_to request.referer,
      danger: t('notices.delete', name: @comment.title)
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def commentable_article
    @commentable = Article.find(params[:article_id]) if params[:article_id]
  end

  def commentable_post
    @commentable = Post.find(params[:post_id]) if params[:post_id]
  end

  def commentable_invit_post
    if params[:invitation_post_id]
      @commentable = InvitationPost.find(params[:invitation_post_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

  def comment_params_with_user
    comment_params.merge(user_id: current_user.id)
  end
end

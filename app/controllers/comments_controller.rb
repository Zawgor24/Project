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
    @comment = @commentable.comments.create(comment_params_with_user)

    flash[:warning] = t('notices.error') unless @comment.save
    redirect_to request.referer
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.commentable
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy

    redirect_to request.referer
  end

  private

  def find_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def authorize_comment
    authorize @comment
  end

  def commentable_article
    @commentable ||= Article.find_by(id: params[:article_id])
  end

  def commentable_post
    @commentable ||= Post.find_by(id: params[:post_id])
  end

  def commentable_invit_post
    @commentable ||= InvitationPost.find_by(id: params[:invitation_post_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

  def comment_params_with_user
    comment_params.merge(user_id: current_user.id)
  end
end

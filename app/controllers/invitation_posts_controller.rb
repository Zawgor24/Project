# frozen_string_literal: true

class InvitationPostsController < ApplicationController
  expose :invitation_post
  expose :comments, -> { invitation_post.comments.includes(:user) }
  expose :sport, id: :sport_id

  before_action :authorize_post, only: %i[edit update destroy]
  before_action :set_categories, only: :show

  def show; end

  def create
    invitation_post = sport.invitation_posts.create(
      post_params.merge(user_id: current_user.id)
    )

    if invitation_post.save
      redirect_to sport,
        success: t('notices.success', name: invitation_post.name)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if invitation_post.update(post_params)
      redirect_to invitation_post,
        success: t('notices.update', name: invitation_post.name)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    invitation_post.destroy

    redirect_to invitation_post.sport,
      danger: t('notices.delete', name: invitation_post.name)
  end

  private

  def authorize_post
    authorize invitation_post
  end

  def post_params
    params.require(:invitation_post).permit(:date, :info, :name, :user_id)
  end
end

# frozen_string_literal: true

class InvitationPostsController < ApplicationController
  before_action :find_invitation_post, only: %i[show edit update destroy]
  before_action :find_sport, only: %i[create new]
  before_action :authorize_post, only: %i[edit update destroy]

  def index
    @invitation_posts = InvitationPost.all
  end

  def show; end

  def new
    @invitation_post = InvitationPost.new
  end

  def create
    @invitation_post = @sport.invitation_posts.create(
      post_params.merge(user_id: current_user.id)
    )

    if @invitation_post.save
      redirect_to @sport,
        success: t('notices.success', name: @invitation_post.name)
    else
      render :new, warning: t('notices.error')
    end
  end

  def edit; end

  def update
    if @invitation_post.update(post_params)
      redirect_to @invitation_post,
        success: t('notices.update', name: @invitation_post.name)
    else
      render :edit, warning: t('notices.error')
    end
  end

  def destroy
    @invitation_post.destroy

    redirect_to @invitation_post.sport,
      danger: t('notices.delete', name: @invitation_post.name)
  end

  private

  def find_invitation_post
    @invitation_post = InvitationPost.find(params[:id])
  end

  def authorize_post
    authorize @invitation_post
  end

  def find_sport
    @sport ||= Sport.find(params[:sport_id])
  end

  def post_params
    params.require(:invitation_post).permit(:date, :info, :name, :user_id)
  end
end

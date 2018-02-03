# frozen_string_literal: true

class InvitationPostsController < ApplicationController
  before_action :find_invitation_post, only: %i[show edit update destroy]
  before_action :find_sport, only: %i[create new destroy]

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
      redirect_to @sport
    else
      render :new
    end
  end

  def edit; end

  def update
    if @invitation_post.update(post_params)
      redirect_to @invitation_post
    else
      render :edit
    end
  end

  def destroy
    @invitation_post.destroy

    redirect_to @sport
  end

  private

  def find_invitation_post
    @invitation_post = InvitationPost.find(params[:id])
  end

  def find_sport
    @sport ||= Sport.find(params[:sport_id])
  end

  def post_params
    params.require(:invitation_post).permit(:date, :info, :name, :user_id)
  end
end

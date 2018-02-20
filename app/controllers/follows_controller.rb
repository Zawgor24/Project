# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :find_followable

  def index
    @followers = @followable.followers(User)
  end

  def create
    current_user.follow!(@followable)

    redirect_to request.referer, success: t('follows.notice.follow')
  end

  def destroy
    current_user.unfollow!(@followable)

    redirect_to request.referer, danger: t('follows.notice.unfollow')
  end

  private

  def find_followable
    @followable = Sport.find_by(id: params[:sport_id])

    @followable = User.find_by(id: params[:user_id])
  end
end

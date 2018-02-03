# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :find_sport

  def followers
    @followers = @sport.followers(User)
  end

  def create
    current_user.follow!(@sport)
    redirect_to request.referer, notice: I18n.t('follows.notice.follow')
  end

  def destroy
    current_user.unfollow!(@sport)
    redirect_to request.referer, notice: I18n.t('follows.notice.unfollow')
  end

  private

  def find_sport
    @sport = Sport.find(params[:sport_id])
  end
end

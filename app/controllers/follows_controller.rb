# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :find_followable

  def index
    @followers = @followable.followers(User)
  end

  def create
    current_user.follow!(@followable)

    redirect_to request.referer, notice: I18n.t('follows.notice.follow')
  end

  def destroy
    current_user.unfollow!(@followable)

    redirect_to request.referer, notice: I18n.t('follows.notice.unfollow')
  end

  private

  def find_followable
    @followable = Sport.find(params[:sport_id]) if params[:sport_id].present?

    @followable = User.find(params[:user_id]) if params[:user_id].present?
  end
end

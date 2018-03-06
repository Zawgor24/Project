# frozen_string_literal: true

class SportsController < ApplicationController
  before_action :find_sport

  def show
    @posts = @sport.invitation_posts.by_updated_time
  end

  private

  def find_sport
    @sport = Sport.find_by(id: params[:id])
  end
end

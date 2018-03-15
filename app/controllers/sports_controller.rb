# frozen_string_literal: true

class SportsController < ApplicationController
  expose :sport

  def show
    @posts = sport.invitation_posts.by_updated_time
  end
end

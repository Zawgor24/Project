# frozen_string_literal: true

class SportsController < ApplicationController
  before_action :find_sport

  def show; end

  def destroy
    @sport.users.find(current_user.id).destroy

    redirect_to @sport
  end

  private

  def find_sport
    @sport = Sport.find(params[:id])
  end
end

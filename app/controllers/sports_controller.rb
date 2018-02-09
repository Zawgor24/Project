# frozen_string_literal: true

class SportsController < ApplicationController
  before_action :find_sport

  def show; end

  private

  def find_sport
    @sport = Sport.find(params[:id])
  end
end

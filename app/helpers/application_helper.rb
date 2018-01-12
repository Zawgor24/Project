# frozen_string_literal: true

module ApplicationHelper
  def show_image(model)
    image_tag(model.avatar_url(:thumb)) if model.avatar.present?
  end
end

# frozen_string_literal: true

module ApplicationHelper
  def show_image(model)
    image_tag(model.avatar_url(:thumb)) if model.avatar.present?
  end

  def show_small_image(model)
    image_tag(model.avatar_url(:little)) if model.avatar.present?
  end

  def build_breadcrumb(category)
    result = []

    category.ancestors.each do |ancestor|
      result << content_tag(:li, class: 'breadcrumb-item') do
        link_to(ancestor.name, category_posts_path(ancestor))
      end
    end

    result << content_tag(:li, category.name, class: 'breadcrumb-item active')

    safe_join(result)
  end

  def flash_class(level)
    {
      notice:  'alert alert-info',
      success: 'alert alert-success',
      error:   'alert alert-error'
    }[level.to_sym] || level.to_s
  end
end

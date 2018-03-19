# frozen_string_literal: true

module CommentHelper
  def small_rounded_image(object)
    image_tag(object.user.avatar, size: '50x50', class: 'rounded-circle')
  end
end

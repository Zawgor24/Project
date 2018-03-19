# frozen_string_literal: true

module ApplicationHelper
  TRUNCATED_WORDS = 40

  def active_page(active_page)
    @active == active_page ? 'active' : ''
  end

  def appointed_time(object)
    object.date.strftime('Appointed time %m/%d/%Y')
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

  def full_name(user)
    "#{user.first_name.titleize} #{user.last_name.titleize}"
  end

  def limit_body(object)
    object.body.truncate_words(TRUNCATED_WORDS)
  end

  def message(conversation)
    "#{conversation.sender_name}:  #{conversation.message}"
  end

  def show_image(object)
    image_tag(object.avatar_url, height: '300')
  end

  def show_small_image(object)
    image_tag(object.avatar, size: '100x100', class: 'rounded-circle')
  end

  def unread_messages_count
    current_user.mailbox.inbox(unread: true).count
  end
end

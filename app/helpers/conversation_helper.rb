# frozen_string_literal: true

module ConversationHelper
  def avatar_sender(user)
    image_tag(user.avatar_url(:small_picture), class: 'rounded-circle')
  end

  def companion(conversation)
    conversation.recipients.reject { |recip| recip.eql?(current_user) }.first
  end
end

# frozen_string_literal: true

module ConversationHelper
  def companion(conversation)
    conversation.recipients.reject { |recip| recip.eql?(current_user) }.first
  end
end

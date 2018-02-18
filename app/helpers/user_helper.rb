# frozen_string_literal: true

module UserHelper
  def conversation(user)
    current_user.mailbox.conversations.select do |conversation|
      conversation.recipients.include?(User.find_by(id: user.id))
    end
  end
end

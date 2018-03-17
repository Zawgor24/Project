# frozen_string_literal: true

module Mailboxer
  class ConversationDecorator < ApplicationDecorator
    WORDS_COUNT = 50
    delegate_all

    def sender_name
      object.last_sender.first_name
    end

    def message
      object.last_message.body.truncate(WORDS_COUNT)
    end
  end
end

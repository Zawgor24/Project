# frozen_string_literal: true

module InvitationPostHelper
  TRUNCATED_WORDS = 40

  def limit_info(object)
    object.info.truncate_words(TRUNCATED_WORDS)
  end
end

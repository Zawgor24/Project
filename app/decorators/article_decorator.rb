# frozen_string_literal: true

class ArticleDecorator < ApplicationDecorator
  WORDS_TOTAL = 40

  delegate_all

  def limit_body
    object.body.truncate_words(WORDS_TOTAL)
  end
end

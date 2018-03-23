# frozen_string_literal: true

class ArticleDecorator < ApplicationDecorator
  delegate_all

  WORDS_TOTAL = 40

  def limit_body
    object.body.truncate_words(WORDS_TOTAL)
  end
end

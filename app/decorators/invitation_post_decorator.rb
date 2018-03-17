# frozen_string_literal: true

class InvitationPostDecorator < ApplicationDecorator
  delegate_all

  def event_date
    if object.date.present?
      I18n.t('posts.date', date: object.date.strftime('%B %d, %Y'))
    end
  end
end

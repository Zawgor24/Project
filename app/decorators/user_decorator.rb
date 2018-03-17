# frozen_string_literal: true

class UserDecorator < Draper::Decorator
  delegate_all

  def gender_type
    object.sex.humanize if object.sex.present?
  end
end

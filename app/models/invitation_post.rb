# frozen_string_literal: true

class InvitationPost < ApplicationRecord
  belongs_to :sport
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
end

# frozen_string_literal: true

class InvitationPost < ApplicationRecord
  belongs_to :sport
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, :info, presence: true
  validates :name, length: { maximum: 40 }
end

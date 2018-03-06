# frozen_string_literal: true

class InvitationPost < ApplicationRecord
  belongs_to :sport
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  scope :by_updated_time, -> { order(updated_at: :desc).includes(:user) }

  validates :name, :info, presence: true
  validates :name, length: { maximum: 40 }
end

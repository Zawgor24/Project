# frozen_string_literal: true

class Sport < ApplicationRecord
  has_many :invitation_posts, dependent: :destroy

  validates :name, :info, presence: true
  validates :name, length: { maximum: 20 }

  acts_as_followable

  mount_uploader :avatar, ImageUploader
end

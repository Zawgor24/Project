# frozen_string_literal: true

class Sport < ApplicationRecord
  has_many :invitation_posts, dependent: :destroy

  validates :name, :info, presence: true

  acts_as_followable

  mount_uploader :avatar, ImageUploader
end

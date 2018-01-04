# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy

  validates :info, length: { maximum: 256 }

  mount_uploader :avatar, AvatarUploader
end

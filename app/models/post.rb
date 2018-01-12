# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category, required: false
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { maximum: 20 }

  mount_uploader :avatar, ImageUploader
end

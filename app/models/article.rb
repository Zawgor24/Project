# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  scope :by_update, -> { order(updated_at: :desc) }

  self.per_page = 5

  validates :title, length: { maximum: 50 }
  validates :title, :body, presence: true

  mount_uploader :avatar, ArticleImageUploader
end

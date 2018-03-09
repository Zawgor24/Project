# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, length: { maximum: 20 }
  validates :title, :body, presence: true

  mount_uploader :avatar, ArticleImageUploader
end

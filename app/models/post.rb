# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category, required: false
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  scope :by_subtree_categories, lambda { |ids|
    order(updated_at: :desc).where(category_id: ids).includes(:user, :category)
  }

  validates :title, :body, presence: true
  validates :title, length: { maximum: 40 }

  mount_uploader :avatar, PostImageUploader
end

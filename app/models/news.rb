# frozen_string_literal: true

class News < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, as: :commentable
  belongs_to :category

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :short_information, presence: true, length: { maximum: 200 }

  scope :by_categories, ->(category) { where(category: category) }
  default_scope { order(created_at: :desc) }

  scope :title_search, lambda { |title_search|
    where('title ILIKE lower(?)', "%#{title_search}%")
  }
end

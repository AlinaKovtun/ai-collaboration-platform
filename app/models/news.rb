# frozen_string_literal: true

class News < ApplicationRecord
  include AASM
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :comments, as: :commentable
  belongs_to :category

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :short_information, presence: true, length: { maximum: 200 }

  scope :ordered_by_views, -> { order(views: :desc) }
  scope :by_categories, ->(category) { where(category: category) }
  scope :ordered, -> { order(created_at: :desc) }

<<<<<<< HEAD
  scope :search, ->(search) { where('title ILIKE lower(?)', "%#{search}%") }
=======
  scope :title_search, lambda { |title_search|
    where('title ILIKE lower(?)', "%#{title_search}%")
  }
  
  aasm do
    state :unapproved, initial: true
    state :approved
    state :rejected
    state :published
    state :archived
  end
>>>>>>> create migrations
end

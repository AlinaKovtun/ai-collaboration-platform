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
  scope :search, ->(search) { where('title ILIKE lower(?)', "%#{search}%") }

  aasm column: 'state' do
    state :draft, initial: true
    state :rejected
    state :published
    state :archived

    event :reject do
      transitions from: [:draft], to: :rejected
    end
    event :publish do
      transitions from: [:draft], to: :published
    end
    event :unpublish do
      transitions from: [:published], to: :draft
    end
    event :archive do
      transitions from: %i[published draft], to: :archived
    end
  end
end

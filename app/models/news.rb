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
    state :approved
    state :rejected
    state :published
    state :archived

    event :approve do
      transitions from: [:draft], to: :approved
    end
    event :reject do
      transitions from: [:draft], to: :rejected
    end
    event :publish do
      transitions from: [:approved], to: :published
    end
    event :unpublish do
      transitions from: [:published], to: :draft
    end
    event :archive do
      transitions from: %i[published approved draft], to: :archived
    end
  end
end
